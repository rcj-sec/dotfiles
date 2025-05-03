# Created by newuser for 5.9
pathifier() {
    . /home/android/.config/scripts/pathifier.sh
}

eval "$(starship init zsh)"

alias lscommands='cat ~/.zshrc | grep alias'

alias ll='ls -Al --group-directories-first --si --color=auto'
alias ls='ls --color=auto --group-directories-first'

alias starpreset="$HOME/.config/starship/preset-manager.sh"

export PATH="/home/android/Android/Sdk/platform-tools:$PATH"
export PATH="/home/android/Android/Sdk/build-tools/35.0.1:$PATH"
