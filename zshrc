# Created by newuser for 5.9


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$( $HOME/miniconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> vars
export  CONDA_CHANGEPS1=false
export ANDROIDSEC="$HOME/Projects/androidsec"
# <<< vars


pathifier() {
    . $HOME/scripts/pathifier.sh
}

eval "$(starship init zsh)"

alias lscommands='cat ~/.zshrc | grep alias'

alias ..="cd .."
alias bat='batcat'
alias ll='ls -Al --group-directories-first --si --color=auto'
alias ls='ls --color=auto --group-directories-first'
alias androidsec="cd $HOME/Projects/androidsec && ls"
alias starpreset="$HOME/.config/starship/preset-manager.sh"
alias dex2jar="$HOME/tools/dex2jar/d2j-dex2jar.sh"
alias find_java_class="$HOME/scripts/find_java_class.sh"
alias registracker="python3 $HOME/scripts/registracker.py"

export PATH="$HOME/Android/Sdk/build-tools/35.0.1:$PATH"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
export PATH="$HOME/tools/apktool:$PATH"
export PATH="$HOME/tools/jadx/build/jadx/bin:$PATH"
export PATH="$HOME/miniconda3/envs/androguard/bin:$PATH"
export PATH="$HOME/tools/gephi-0.10.1/bin:$PATH"
