import Base: send

"""
    IRC(;
        server::AbstractString=error("No server given"),
        channel::AbstractString=error("No channel given"),
        port::Int=6667,
        nick::AbstractString=randstring(16),
    )

Initialize a new IRC channel source.

# Arguments
* `server::AbstractString=error("No server given")`: Server to connect to.
* `channel::AbstractString=error("No channel given")`: Channel to join.
* `port::Int=6667`: Port to connect via.
* `nick::AbstractString=randstring(16)`: Nickname to assume.
"""
struct IRC <: Source
    conn::TCPSocket  # Connection to the channel.

    function IRC(;
        server::AbstractString=error("No server given"),
        channel::AbstractString=error("No channel given"),
        port::Int=6667,
        nick::AbstractString=randstring(16),
    )
        s = randstring(16)  # TODO: Make a "real" user.
        conn = connect(server, port)
        write(conn, "PASS none\nNICK $nick\nUSER $s $s $s $s\nJOIN $channel\n")

        new(conn)
    end
end

function listen(source::IRC, channel::Channel{Message})
    while true
        s = readline(source.conn)
        if startswith(s, "PING")
            write(source.conn, "PONG $(String(split(s)[end]))\n")
        elseif contains(s, ":Nickname is already in use.")
            println("Changing nickname.")
            write(source.conn, "NICK $(randstring(16))\n")
        elseif !all(isspace, s)
            tokens = map(x -> String(x), split(s, " "; limit=2))
            put!(channel, Message(tokens[2]; author=tokens[1]))
        end
    end
end

function send(source::IRC, msg::AbstractString)
    # Messages need to follow the following specification:
    # https://en.wikipedia.org/wiki/List_of_Internet_Relay_Chat_commands
    write(source.conn, endswith(msg, "\n") ? msg : "$msg\n")
end
