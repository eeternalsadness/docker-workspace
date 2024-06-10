# Overview

This is the repo to set up Bach's workspace container.

Add this to .zshrc or .bashrc.

``` bash
alias wsinit='docker run -dit \
    --name workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    caudit123/workspace:latest'

alias wsrun='docker exec -it workspace zsh'
```