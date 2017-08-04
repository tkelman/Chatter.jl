import Base: send

abstract type Source end

function listen(source::Source, channel::Channel{AbstractString})
    error("listen not implemented for $(typeof(source))")
end

function send(source::Source, msg::AbstractString)
    error("send not implemented for $(typeof(source))")
end
