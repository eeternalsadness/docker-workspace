# Overview

This is the repo to set up Bach's workspace container.

Add this to .zshrc or .bashrc. Change GIT_USER_NAME and GIT_EMAIL as necessary

``` bash
export OBSIDIAN="<HOST_OBSIDIAN_DIR>"
export OBSIDIAN_INBOX="<HOST_OBSIDIAN_INBOX_DIR>"
export REPO="<HOST_REPO_DIR>"

alias wsinit='docker run -dit \
    --name workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $REPO:/root/Repo \
    -v $OBSIDIAN:/root/Obsidian/0-inbox \
    caudit123/workspace:latest'
alias wsrun='docker start workspace; docker exec -it workspace zsh'
alias wstest='docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $REPO:/root/Repo \
    -v $OBSIDIAN:/root/Obsidian/0-inbox \
    caudit123/workspace:latest'
alias wsupdate='docker pull caudit123/workspace:latest && docker image prune -f'
alias wsrm='docker stop workspace; docker rm workspace'
```
