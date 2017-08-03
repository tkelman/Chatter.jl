using Chatter
using Base.Test

struct Foo <: Chatter.Source end

client = ChatterClient(Foo())
push!(client.messages, "A", "B", "C", "D", "E", "F", "G")

@test get!(client) == ["A"]
@test get!(client; n=2) == ["B", "C"]
@test flush!(client) == ["D", "E", "F", "G"]
@test isempty(client.messages)
