pathifier() {
    . $HOME/scripts/pathifier.sh
}

export RCFILE="$HOME/.zshrc"

eval "$(starship init zsh)"

alias lscommands='cat ~/.zshrc | grep alias'

alias ..="cd .."
alias downloads="cd $HOME/Downloads"
alias ll='ls -Al --group-directories-first --si --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias androidsec="cd $HOME/Projects/androidsec && ls"
alias starpreset="$HOME/.config/starship/preset-manager.sh"
alias dex2jar="$HOME/tools/dex2jar/d2j-dex2jar.sh"
alias find_java_class="$HOME/scripts/find_java_class.sh"
alias registracker="python3 $HOME/scripts/registracker.py"
alias cheetah="python3 $HOME/scripts/cheetah/cheetah.py"
alias vim="nvim"
alias theme="$HOME/scripts/change-theme.sh"
alias icat="kitten icat"

export PATH="$PATH:$HOME/Android/Sdk/build-tools/35.0.1"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"
export PATH="$PATH:$HOME/tools/apktool"
export PATH="$PATH:$HOME/tools/jadx/build/jadx/bin"
export PATH="$PATH:$HOME/miniconda3/envs/androguard/bin"
export PATH="$PATH:$HOME/tools/gephi-0.10.1/bin"
export PATH="$PATH:$HOME"

