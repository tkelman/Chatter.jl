import Base: send

"""
A source of communication.

Note that `Source` is abstract, and that its subtypes have the responsibility
of implementing [`listen`](@ref) and [`deliver`](@ref) such that
their behaviour is as described below.
"""
abstract type Source end

"""
    listen(source::Source, channel::Channel{Message}) -> Task

Listen for messages and `put!` them into `channel`.

# Arguments
* `source::Source`: Source of communication.
* `channel::Channel{Message}`: Channel for passing messages.

Returns the listening `Task`.
"""
function listen(source::Source, channel::Channel{AbstractString})
    error("listen is not implemented for $(typeof(source))")
end

"""
    deliver(source::Source, msg::AbstractString) -> Int

Deliver a message via `source`.

# Arguments
* `source::Source`: Source of communication.
* `msg::AbstractString`: Message to be delivered.

Returns the number of bytes sent.
"""
function deliver(source::Source, msg::AbstractString)
    error("deliver is not implemented for $(typeof(source))")
end
