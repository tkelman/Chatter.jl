using Documenter, Chatter

makedocs(
    modules=[Chatter],
    format=:html,
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/christopher-dG/Chatter.jl/blob/{commit}{path}#L{line}",
    sitename="Chatter.jl",
    authors="Chris de Graaf",
    assets=[],
)

deploydocs(
    repo = "github.com/christopher-dG/Chatter.jl.git",
    target = "build",
    deps = nothing,
    make = nothing,
)
