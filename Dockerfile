ARG UBUNTU_VER="22.04"

FROM ubuntu:${UBUNTU_VER}

# common tools
RUN apt update && apt install -y git zsh ca-certificates unzip curl tmux

# install zsh
ENV TERM=xterm-256color
RUN touch /root/.zshrc && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions /root/.zsh/zsh-autosuggestions && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.zsh/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k && \
    chsh -s $(which zsh)

# copy zsh configs
COPY .zshrc .p10k.zsh /root/

# neovim
RUN apt install -y ninja-build gettext cmake && \
    git clone --depth=1 https://github.com/neovim/neovim --branch v0.9.5 && \
    cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install && \
    cd .. && rm -rf neovim && \
    git clone --depth=1 https://github.com/LazyVim/starter ~/.config/nvim && \
    rm -rf ~/.config/nvim/.git

# copy neovim configs
COPY ./nvim /root/.config/nvim

# aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# tfswitch
ARG TF_VERSION=1.8.1
RUN curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/master/install.sh | bash && \
    tfswitch ${TF_VERSION}

ENTRYPOINT [ "/bin/zsh" ]