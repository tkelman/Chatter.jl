using Chatter
using Base.Test

struct Foo <: Chatter.Source end

client = ChatterClient(Foo())
for message in ["A", "B", "C", "D", "E", "F", "G"]
    push!(client.messages, Chatter.Message(message))
end

@test get!(client) == map(m -> Chatter.Message(m), ["A"])
@test get!(client; n=2) == map(m -> Chatter.Message(m), ["B", "C"])
@test flush!(client) == map(m -> Chatter.Message(m), ["D", "E", "F", "G"])
@test isempty(client.messages)
