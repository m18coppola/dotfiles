export ZSH="$HOME/.oh-my-zsh"
plugins=(git colorize zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

export EDITOR=vim
export GIT_LFS_SKIP_SMUDGE=1
export PATH="$HOME/.local/defn:$HOME/.local/bin:$PATH"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

PROMPT="; "
RPROMPT="%~"
PS2="| "

DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
setopt nobanghist

alias svba='source ./venv/bin/activate'

# vim keybinds
bindkey -v
bindkey '^r' history-incremental-search-backward
bindkey '\ee' _aichat_zsh

# userspace python env
if [ -f USER_PYVENV ]; then
	. $USER_PYVENV/bin/activate
	export PS1="$_OLD_VIRTUAL_PS1"
fi
