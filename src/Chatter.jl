module Chatter

include("message.jl")
include("source.jl")
include("client.jl")
include(joinpath("sources", "IRC.jl"))
include(joinpath("sources", "subreddit.jl"))

export ChatterClient, start, get!, flush!, send, IRC, Subreddit

end
