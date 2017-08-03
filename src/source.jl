import Base: send

immutable Source end

# `listen` must be implemented by any subtype of `Source`l.
# Implementations must `put!` new messages as they are received.
function listen(source::Source, channel::Channel{AbstractString})
    error("Not implemented for $(typeof(source))")
end

# `send` doesn't necessarily need to be implemented for every source,
# think of it as a bonus wherever practical.
function send(source::Source, msg::AbstractString)
    error("Not implemented for $(typeof(source))")
end
