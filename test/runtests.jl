using Chatter
using Base.Test

struct Foo <: Chatter.Source end
struct BarMessage <: Chatter.Message
    msg::AbstractString
    BarMessage(msg) = new(msg)
end

client = ChatterClient(Foo())
for message in ["A", "B", "C", "D", "E", "F", "G"]
    push!(client.messages, BarMessage(message))
end

@test map(m -> m.msg, get!(client)) == ["A"]
@test map(m -> m.msg, get!(client; n=2)) == ["B", "C"]
@test map(m -> m.msg, flush!(client)) == ["D", "E", "F", "G"]
@test isempty(client.messages)
