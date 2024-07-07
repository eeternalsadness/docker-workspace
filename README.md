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
    -v $REPO:<CONTAINER_REPO_DIR> \
    -v $OBSIDIAN:<CONTAINER_OBSIDIAN_DIR> \
    -e OBSIDIAN=<CONTAINER_OBSIDIAN_DIR> \
    -e OBSIDIAN_INBOX=<CONTAINER_OBSIDIAN_INBOX_DIR> \
    -e REPO=<CONTAINER_REPO_DIR> \
    -e "GIT_USER_NAME=<GIT_USER_NAME>" \
    -e GIT_EMAIL=<GIT_EMAIL> \
    -e GIT_CRED_CACHE_TIMEOUT=<GIT_CRED_CACHE_TIMEOUT> \
    caudit123/workspace:latest'
alias wsrun='docker start workspace; docker exec -it workspace zsh'
alias wstest='docker run -it --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v $REPO:<CONTAINER_REPO_DIR> \
    -v $OBSIDIAN:<CONTAINER_OBSIDIAN_DIR> \
    -e OBSIDIAN=<CONTAINER_OBSIDIAN_DIR> \
    -e OBSIDIAN_INBOX=<CONTAINER_OBSIDIAN_INBOX_DIR> \
    -e REPO=<CONTAINER_REPO_DIR> \
    -e "GIT_USER_NAME=<GIT_USER_NAME>" \
    -e GIT_EMAIL=<GIT_EMAIL> \
    -e GIT_CRED_CACHE_TIMEOUT=<GIT_CRED_CACHE_TIMEOUT> \
    caudit123/workspace:latest'
alias wsupdate='docker pull caudit123/workspace:latest && docker image prune -f'
alias wsrm='docker stop workspace; docker rm workspace'
```
