# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export KUBECONFIG="/mnt/c/dev/kubernetes/rnd-admin.conf:/mnt/c/Users/rahul/.kube/config"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL10K_MODE="nerfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status kubecontext time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# TMUX Config
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOCONNECT=false
ZSH_TMUX_CONFIG=~/.tmux.conf

plugins=(
    git
    tmux
    globalias
    common-aliases
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)
source <(helm completion zsh)

alias k=kubectl
complete -F __start_kubectl k
