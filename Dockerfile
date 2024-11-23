ARG UBUNTU_VER="22.04"

FROM ubuntu:${UBUNTU_VER}

WORKDIR /root/

# common tools
RUN apt-get update && apt-get install -y git ca-certificates unzip curl wget tmux fzf

# neovim
RUN apt-get install -y ninja-build gettext cmake && \
    git clone --depth=1 https://github.com/neovim/neovim && \
    cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install && \
    cd .. && rm -rf neovim && \
    git clone --depth=1 https://github.com/LazyVim/starter ~/.config/nvim && \
    rm -rf $HOME/.config/nvim/.git

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    aws/install && rm awscliv2.zip

# docker
RUN apt-get install -y docker.io && usermod -aG docker root && newgrp docker

# time zone
ARG TZ_AREA=Asia
ARG TZ_ZONE=Bangkok
RUN echo "tzdata tzdata/Areas select ${TZ_AREA}}" > /tmp/preseed.conf && \
    echo "tzdata tzdata/Zones/Asia select ${TZ_ZONE}}" >> /tmp/preseed.conf && \
    debconf-set-selections /tmp/preseed.cfg && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
    rm /tmp/preseed.conf

# tfswitch
ARG TF_VERSION=1.8.1
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash && \
    tfswitch ${TF_VERSION}

# git config
ENV GIT_USER_NAME="Bach Nguyen" GIT_EMAIL=69bnguyen@gmail.com GIT_CRED_CACHE_TIMEOUT=3600
RUN git config --global credential.helper 'cache --timeout $GIT_CRED_CACHE_TIMEOUT' && \
    git config --global user.name "${GIT_USER_NAME}" && \
    git config --global user.email "${GIT_EMAIL}" && \
    git config --global push.autoSetupRemote true && \
    git config --global safe.directory '*'

# software package
RUN apt-get install -y python3-venv npm luarocks

# set up scripts
RUN git clone --depth=1 https://github.com/eeternalsadness/scripts $HOME/scripts

# set up dotfiles
ENV DOTFILES_DIR="$HOME/.dotfiles"
RUN git clone --depth=1 https://github.com/eeternalsadness/dotfiles.git $DOTFILES_DIR && \
    bash $DOTFILES_DIR/scripts/init-dotfiles.sh

ENTRYPOINT [ "/bin/bash" ]
