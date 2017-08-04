# Chatter

[![stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://christopher-dG.github.io/Chatter.jl/stable)
[![latest](https://img.shields.io/badge/docs-latest-blue.svg)](https://christopher-dG.github.io/Chatter.jl/latest)
[![Build Status](https://travis-ci.org/christopher-dG/Chatter.jl.svg?branch=master)](https://travis-ci.org/christopher-dG/Chatter.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/github/christopher-dG/Chatter.jl?svg=true)](https://ci.appveyor.com/project/christopher-dG/Chatter-jl)
[![codecov](https://codecov.io/gh/christopher-dG/Chatter.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/christopher-dG/Chatter.jl)

**Chatter.jl is a framework(?) for interacting with a variety of messaging platforms.**

## Examples

### IRC

```julia
julia> using Chatter

julia> client = ChatterClient(IRC(;server="irc.freenode.net", channel="#botters-test"))
Chatter.ChatterClient(Chatter.Message[], Chatter.IRC(TCPSocket(RawFD(19) open, 0 bytes waiting)))

julia> start(client)
Task (runnable) @0x00007f3efd2b6230

julia> messages = flush!(client)
# A bunch of MOTD lines

julia> get!(client)[1].body  # A new message has arrived.
"PRIVMSG #botters-test :hello github"

julia> send(client, "PRIVMSG #botters-test hello")
28
```

### Reddit

```julia
julia> using Chatter

julia> client = ChatterClient(Subreddit("rarepuppers"))
Chatter.ChatterClient(Chatter.Message[], Chatter.Subreddit("rarepuppers", "new"))

julia> start(client)
Task (runnable) @0x00007fe850e302b0

julia> get!(client)[1]
Chatter.SubredditMessage("Doggo evolution, Peach my puppy", "https://redd.it/6rip1o")
```
