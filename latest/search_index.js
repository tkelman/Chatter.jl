var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#Chatter-1",
    "page": "Home",
    "title": "Chatter",
    "category": "section",
    "text": "(Image: stable) (Image: latest) (Image: Build Status) (Image: Build status) (Image: codecov)Chatter.jl is a framework(?) for interacting with a variety of messaging platforms."
},

{
    "location": "index.html#Examples-1",
    "page": "Home",
    "title": "Examples",
    "category": "section",
    "text": ""
},

{
    "location": "index.html#IRC-1",
    "page": "Home",
    "title": "IRC",
    "category": "section",
    "text": "julia> using Chatter\n\njulia> client = ChatterClient(IRC(;server=\"irc.freenode.net\", channel=\"#botters-test\"))\nChatter.ChatterClient(Chatter.Message[], Chatter.IRC(TCPSocket(RawFD(19) open, 0 bytes waiting)))\n\njulia> start(client)\nTask (runnable) @0x00007f3efd2b6230\n\njulia> messages = flush!(client)\n# A bunch of MOTD lines\n\njulia> get!(client)[1].body  # A new message has arrived.\n\"PRIVMSG #botters-test :hello github\"\n\njulia> send(client, \"PRIVMSG #botters-test hello\")\n28"
},

{
    "location": "index.html#Reddit-1",
    "page": "Home",
    "title": "Reddit",
    "category": "section",
    "text": "julia> using Chatter\n\njulia> client = ChatterClient(Subreddit(\"rarepuppers\"))\nChatter.ChatterClient(Chatter.Message[], Chatter.Subreddit(\"rarepuppers\", \"new\"))\n\njulia> start(client)\nTask (runnable) @0x00007fe850e302b0\n\njulia> get!(client)[1]\nChatter.SubredditMessage(\"Doggo evolution, Peach my puppy\", \"https://redd.it/6rip1o\")"
},

{
    "location": "pages/client.html#",
    "page": "ChatterClient",
    "title": "ChatterClient",
    "category": "page",
    "text": "CurrentModule = Chatter"
},

{
    "location": "pages/client.html#Chatter.ChatterClient",
    "page": "ChatterClient",
    "title": "Chatter.ChatterClient",
    "category": "Type",
    "text": "ChatterClient(source::Source) -> ChatterClient\n\nCreate a new ChatterClient from source.\n\nArguments\n\nsource::Source: Source of communication.\n\n\n\n"
},

{
    "location": "pages/client.html#Base.start",
    "page": "ChatterClient",
    "title": "Base.start",
    "category": "Function",
    "text": "start(client::ChatterClient) -> Task\n\nMake client start listening for new messages.\n\nArguments\n\nclient::ChatterClient: The client to start.\n\nReturns the listener's Task.\n\n\n\n"
},

{
    "location": "pages/client.html#Base.get!",
    "page": "ChatterClient",
    "title": "Base.get!",
    "category": "Function",
    "text": "get!(client::ChatterClient; n=1) -> Vector{Message}\n\nGet the n oldest unread message(s) from client.\n\nArguments\n\nclient::ChatterClient: Client whose messages are being read.\n\nKeyword Arguments\n\nn::Int=1: Number of messages to fetch.\n\nReturns messages ordered oldest to newest.\n\n\n\n"
},

{
    "location": "pages/client.html#Chatter.flush!",
    "page": "ChatterClient",
    "title": "Chatter.flush!",
    "category": "Function",
    "text": "flush!(client::ChatterClient) -> Vector{Message}\n\nGet all unread messages from client.\n\nArguments\n\nclient::ChatterClient: client whose messages are being read.\n\nReturns messages ordered oldest to newest.\n\n\n\n"
},

{
    "location": "pages/client.html#Base.send",
    "page": "ChatterClient",
    "title": "Base.send",
    "category": "Function",
    "text": "send(client::ChatterClient, msg::AbstractString) -> Int\n\nSend a message to client's source.\n\nArguments\n\nclient::ChatterClient: Client whose source we're sending to.\nmsg::AbstractString: Message to be sent.\n\nReturns the number of bytes written.\n\n\n\n"
},

{
    "location": "pages/client.html#ChatterClient-1",
    "page": "ChatterClient",
    "title": "ChatterClient",
    "category": "section",
    "text": "ChatterClient\nstart\nget!\nflush!\nsend"
},

{
    "location": "pages/sources.html#",
    "page": "Sources",
    "title": "Sources",
    "category": "page",
    "text": "CurrentModule = Chatter"
},

{
    "location": "pages/sources.html#Chatter.Source",
    "page": "Sources",
    "title": "Chatter.Source",
    "category": "Type",
    "text": "A source of communication.\n\nNote that Source is abstract, and that its subtypes have the responsibility of implementing listen and deliver such that their behaviour is as described below.\n\n\n\n"
},

{
    "location": "pages/sources.html#Chatter.listen",
    "page": "Sources",
    "title": "Chatter.listen",
    "category": "Function",
    "text": "listen(source::Source, channel::Channel{Message}) -> Task\n\nListen for messages and put! them into channel.\n\nArguments\n\nsource::Source: Source of communication.\nchannel::Channel{Message}: Channel for passing messages.\n\nReturns the listening Task.\n\n\n\n"
},

{
    "location": "pages/sources.html#Chatter.deliver",
    "page": "Sources",
    "title": "Chatter.deliver",
    "category": "Function",
    "text": "deliver(source::Source, msg::AbstractString) -> Int\n\nDeliver a message via source.\n\nArguments\n\nsource::Source: Source of communication.\nmsg::AbstractString: Message to be delivered.\n\nReturns the number of bytes sent.\n\n\n\n"
},

{
    "location": "pages/sources.html#Source-1",
    "page": "Sources",
    "title": "Source",
    "category": "section",
    "text": "Source\nlisten\ndeliver"
},

{
    "location": "pages/sources.html#Chatter.IRC",
    "page": "Sources",
    "title": "Chatter.IRC",
    "category": "Type",
    "text": "IRC(;\n    server::AbstractString=error(\"No server given\"),\n    channel::AbstractString=error(\"No channel given\"),\n    port::Int=6667,\n    nick::AbstractString=randstring(16),\n)\n\nInitialize a new IRC channel source.\n\nArguments\n\nserver::AbstractString=error(\"No server given\"): Server to connect to.\nchannel::AbstractString=error(\"No channel given\"): Channel to join.\nport::Int=6667: Port to connect via.\nnick::AbstractString=randstring(16): Nickname to assume.\n\n\n\n"
},

{
    "location": "pages/sources.html#Chatter.IRCMessage",
    "page": "Sources",
    "title": "Chatter.IRCMessage",
    "category": "Type",
    "text": "IRCMessage(body::AbstractString, author::AbstractString) -> IRCMessage\n\nCreate a new IRC message.\n\nArguments\n\nbody::AbstractString: Message contents.\nauthor::AbstractString: Author of the message.\n\n\n\n"
},

{
    "location": "pages/sources.html#IRC-1",
    "page": "Sources",
    "title": "IRC",
    "category": "section",
    "text": "IRC\nIRCMessage"
},

{
    "location": "pages/sources.html#Chatter.Subreddit",
    "page": "Sources",
    "title": "Chatter.Subreddit",
    "category": "Type",
    "text": "Subreddit(sub::AbstractString; feed::AbstractString=\"new\")\n\nInitialize a new subreddit source.\n\nArguments\n\nsub::AbstractString: Subreddit to monitor.\n\nKeyword Arguments\n\nfeed::AbstractString=\"new\": Retrieve new posts or hot posts.\n\n\n\n"
},

{
    "location": "pages/sources.html#Chatter.SubredditMessage",
    "page": "Sources",
    "title": "Chatter.SubredditMessage",
    "category": "Type",
    "text": "SubredditMessage(title::AbstractString, link::AbstractString) -> SubredditMessage\n\nCreate a new subreddit message.\n\nArguments\n\ntitle::AbstractString: Title of the post.\nlink::AbstractString: Shortened URL.\n\n\n\n"
},

{
    "location": "pages/sources.html#Subreddit-1",
    "page": "Sources",
    "title": "Subreddit",
    "category": "section",
    "text": "Subreddit\nSubredditMessage"
},

{
    "location": "pages/index.html#",
    "page": "Index",
    "title": "Index",
    "category": "page",
    "text": ""
},

{
    "location": "pages/index.html#Index-1",
    "page": "Index",
    "title": "Index",
    "category": "section",
    "text": ""
},

]}
