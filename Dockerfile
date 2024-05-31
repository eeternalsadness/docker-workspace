ARG UBUNTU_VER="22.04"

FROM ubuntu:${UBUNTU_VER}

# ARG FONT_DIR="/usr/share/fonts/truetype/meslo"

# common tools
RUN apt update && apt install -y curl git zsh ca-certificates

# copy fonts
# RUN mkdir -p ${FONT_DIR} && apt install fontconfig 
# COPY ./fonts ${FONT_DIR}
# RUN fc-cache -fv

# install zsh
RUN touch /root/.zshrc && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions /root/.zsh/zsh-autosuggestions && \
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.zsh/zsh-syntax-highlighting && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/.oh-my-zsh/custom/themes/powerlevel10k && \
    chsh -s $(which zsh)

ENTRYPOINT [ "/bin/zsh" ]