#! /bin/bash

git_clone_or_pull() {
    if ! git clone "${1}" "${2}" 2>/dev/null && [ -d "${2}" ]; then
        echo "Clone failed because the folder ${2} exists"
        git pull -C "${2}"
        echo "Git pull in ${2}"
    else
        "Cloned in ${2}"
    fi
}

install_shell() {
    echo -e '\e[0;33mSetting up zsh as the shell\e[0m'

    ## zsh
    sudo apt install zsh -y

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    git_clone_or_pull "https://github.com/zsh-users/zsh-autosuggestions" "~/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    git_clone_or_pull "https://github.com/zsh-users/zsh-syntax-highlighting.git" "~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    git_clone_or_pull "https://github.com/romkatv/powerlevel10k.git" "~/.oh-my-zsh/custom/themes/powerlevel10k"

    ## tmux
    echo -e '\e[0;33mSetting up tmux\e[0m'
    sudo apt install tmux urlview -y
    git_clone_or_pull "https://github.com/tmux-plugins/tpm" "~/.tmux/plugins/tpm"
    return 0
}

install_container_tools() {
    # kubectl tooling
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.4/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl

    # helm
    wget -q https://get.helm.sh/helm-v3.2.4-linux-amd64.tar.gz
    tar xvzf helm-v3.2.4-linux-amd64.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/

    #Cleanup helm
    rm -f helm-v3.2.4-linux-amd64.tar.gz
    rm -r -f linux-amd64
}

install_dotfiles() {
    echo -e '\e[0;33mSetting up standard dotfiles from wsl folder \e[0m'

    rm ~/.zshrc
    rm ~/.tmux.conf
    rm ~/.vimrc

    git clone https://github.com/rahulrai-in/pc-init ~/code/github/pc-init

    cp -nf ~/code/github/pc-init/wsl/.zshrc ~/.zshrc
    cat ~/.zshrc
    cp -nf ~/code/github/pc-init/wsl/.tmux.conf ~/.tmux.conf
    cat ~/.tmux.conf
    cp -nf ~/code/github/pc-init/wsl/.vimrc ~/.vimrc
    cat ~/.vimrc
    return 0
}

echo -e '\e[0;33mPreparing to setup WSL\e[0m'

# Add universe repository
sudo apt-add-repository universe

## General updates
sudo apt update && sudo apt upgrade

## Utilities
sudo apt install unzip curl jq -y

# Create standard github clone location
mkdir -p ~/code/github

install_shell
install_container_tools
install_dotfiles

chmod +x ~/code/github/pc-init/wsl/bin/network_info.sh
chmod +x ~/code/github/pc-init/wsl/bin/tmux_responsive.sh
tmux source ~/.tmux.conf
chsh -s $(which zsh)
echo "Done!"
