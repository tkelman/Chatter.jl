using HTTP
using JSON

"""
    Subreddit(sub::AbstractString; feed::AbstractString="new")

Initialize a new subreddit source.

# Arguments
* `sub::AbstractString`: Subreddit to monitor.

# Keyword Arguments
* `feed::AbstractString="new"`: Retrieve new posts or hot posts.
"""
struct Subreddit <: Source
    sub::AbstractString  # Subreddit name.
    feed::AbstractString  # Feed to refresh.

    function Subreddit(sub::AbstractString; feed::AbstractString="new")
        sub = lowercase(sub)
        feed = lowercase(feed)
        if !in(feed, ["new", "hot"])
            error("Invalid feed.")
        end
        new(sub, feed)
    end
end

function listen(source::Subreddit, channel::Channel{Message})
    uri = HTTP.URI("http://reddit.com/r/$(source.sub)/$(source.feed).json?limit=1")
    id = ""
    while true
        try
            data = JSON.parse(HTTP.request(uri).body)["data"]["children"][end]["data"]
            if data["id"] != id
                id = data["id"]
                title = data["title"]
                link = "https://redd.it/$id"
                put!(channel, SubredditMessage(title, link))
            end
        catch
            warn("Parsing response failed.")
        end
        sleep(60)
    end
end

"""
    SubredditMessage(title::AbstractString, link::AbstractString) -> SubredditMessage

Create a new subreddit message.

# Arguments
* `title::AbstractString`: Title of the post.
* `link::AbstractString`: Shortened URL.
"""
struct SubredditMessage <: Message
    title::AbstractString  # Title of the post.
    link::AbstractString  # Shortened URL.

    SubredditMessage(title, link) = new(title, link)
end
