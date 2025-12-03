pathifier() {
    . $HOME/scripts/pathifier.sh
}

tabs -4
bindkey "^[[3~" delete-char
bindkey -v

export PICTURES="$HOME/Pictures"
export DOWNLOADS="$HOME/Downloads"
export RCFILE="$HOME/.zshrc"
export NVIM="$HOME/.config/nvim"

eval "$(starship init zsh)"

alias lscommands='cat ~/.zshrc | grep alias'size

alias downloads="cd $HOME/Downloads"

alias ..="cd .."
alias ll='ls -Al --group-directories-first --si --color=auto'
alias ls='ls --color=auto --group-directories-first'

alias starpreset="$HOME/.config/starship/preset-manager.sh"
alias find_java_class="$HOME/scripts/find_java_class.sh"
alias registracker="python3 $HOME/scripts/registracker.py"
alias cheetah="python3 $HOME/Projects/cheetah/cheetah.py"

alias jd-gui="java -jar $HOME/tools/android/jd-gui.jar"
alias apktool="java -jar $HOME/tools/android/apktool.jar"

alias vim="nvim"
alias icat="kitten icat"
alias wpp="$HOME/scripts/wpp.sh"

alias gxx="/home/reus/opt/cross-compilers/gcc-i686/bin/i686-elf-gcc"
export PATH="$PATH:$HOME/Android/Sdk/build-tools/35.0.1"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

export PATH="$PATH:$HOME/dotfiles/scripts"
