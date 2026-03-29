pathifier() {
    . $HOME/scripts/pathifier.sh
}

tabs -4

bindkey -v
bindkey -M viins '^?' backward-delete-char

export PICTURES="$HOME/Pictures"
export DOWNLOADS="$HOME/Downloads"
export RCFILE="$HOME/.zshrc"


alias lsalias='cat ~/.zshrc | grep alias'

alias Downloads="cd $HOME/Downloads"
alias Pictures="cd $HOME/Pictures"

alias ..="cd .."
alias cdb="cd -"
alias ll='ls -Al'
alias ls='ls --group-directories-first --indicator-style=classify'

alias starpreset="$HOME/.config/starship/preset-manager.sh"
alias find_java_class="$HOME/scripts/find_java_class.sh"
alias registracker="python3 $HOME/scripts/registracker.py"
alias cheetah="python3 $HOME/Projects/cheetah/cheetah.py"

alias jd-gui="java -jar $HOME/tools/android/jd-gui.jar"
alias apktool="java -jar $HOME/tools/android/apktool.jar"

alias vim="nvim"
alias icat="kitten icat"

export PATH="$PATH:$HOME/Android/Sdk/build-tools/35.0.1"
export PATH="$PATH:$HOME/Android/Sdk/platform-tools"

export PATH="$PATH:$HOME/dotfiles/scripts"
export PATH="$PATH:$HOME/.local/bin"

eval "$(starship init zsh)"
eval "$(dircolors ~/.dircolors)"

export PATH="$PATH:$HOME/tools/xcomp/gcc_i686_elf/bin"
export CDPATH=".:$HOME/osdev/code:$CDPATH"

DISABLE_AUTO_TITLE="true"
export PATH="$PATH:$HOME/.cargo/bin"
