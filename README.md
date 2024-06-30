# Overview

This is the repo to set up Bach's workspace container.

Add this to .zshrc or .bashrc. Change GIT_USER_NAME and GIT_EMAIL as necessary

``` bash
alias wsinit='docker run -dit \
    --name workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e "GIT_USER_NAME=<GIT_USER_NAME>" \
    -e GIT_EMAIL=<GIT_EMAIL> \
    -e GIT_CRED_CACHE_TIMEOUT=<GIT_CRED_CACHE_TIMEOUT> \
    caudit123/workspace:latest'
alias wsrun='docker start workspace; docker exec -it workspace zsh'
alias wstest='docker run -it --rm caudit123/workspace:latest'
alias wsupdate='docker pull caudit123/workspace:latest && docker image prune -f'
alias wsrm='docker stop workspace; docker rm workspace'
```
