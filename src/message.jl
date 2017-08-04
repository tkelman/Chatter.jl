import Base: ==

struct Message
    body::AbstractString
    author::AbstractString

    function Message(body::AbstractString; author::AbstractString="unknown")
        new(body, author)
    end
end

==(a::Message, b::Message) = a.body == b.body && a.author == b.author
