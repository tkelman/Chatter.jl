module Chatter

include("source.jl")
include("client.jl")

export ChatterClient, start, get!, flush!, send

end
