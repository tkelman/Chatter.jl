import Base: start, get!, send

"""
    ChatterClient(source::Source) -> ChatterClient

Create a new `ChatterClient` from `source`.

# Arguments
* `source::Source`: Source of communication.
"""
struct ChatterClient
    messages::Vector{Message}  # Ordered oldest to newest.
    source::Source  # Source of sending/receiving.

    ChatterClient(source::Source) = new(Vector(), source)
end

"""
    start(client::ChatterClient) -> Task

Make `client` start listening for new messages.

# Arguments
* `client::ChatterClient`: The client to start.

Returns the listener's `Task`.
"""
function start(client::ChatterClient)
    @async begin
        channel = Channel{Message}(Inf)
        @async listen(client.source, channel)
        while true
            push!(client.messages, take!(channel))
        end
    end
end

"""
    get!(client::ChatterClient; n=1) -> Vector{Message}

Get the `n` oldest unread message(s) from `client`.

# Arguments
* `client::ChatterClient`: Client whose messages are being read.

# Keyword Arguments
* `n::Int=1`: Number of messages to fetch.

Returns messages ordered oldest to newest.
"""
function get!(client::ChatterClient; n::Int=1)
    n = min(n, length(client.messages))
    messages = client.messages[1:n]
    deleteat!(client.messages, 1:n)
    return messages
end

"""
    flush!(client::ChatterClient) -> Vector{Message}

Get all unread messages from `client`.

# Arguments
* `client::ChatterClient`: client whose messages are being read.

Returns messages ordered oldest to newest.
"""
flush!(client::ChatterClient) = get!(client; n=length(client.messages))

"""
    send(client::ChatterClient, msg::AbstractString) -> Int

Send a message to `client`'s source.

# Arguments
* `client::ChatterClient`: Client whose source we're sending to.
* `msg::AbstractString`: Message to be sent.

Returns the number of bytes written.
"""
send(client::ChatterClient, msg::AbstractString) = deliver(client.source, msg)
