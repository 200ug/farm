. ~/.config/zsh/aliases.sh
. ~/.config/zsh/exports.sh

PS1="%{$(tput setaf 15)%}%n%{$(tput setaf 39)%}@%{$(tput setaf 15)%}%m %{$(tput setaf 39)%}%1~ %{$(tput sgr0)%}$ "

HISTFILE="~/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt inc_append_history

# case insensitive tab-completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# set up fzf mappings & fuzzy completion (open with ctrl+t)
source <(fzf --zsh)

# alternatively manual installation `git clone https://github.com/zsh-users/zsh-autosuggestions zsh-autosuggestions`
# for "source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey -e
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

precmd () { print -Pn "\e]2;%-3~\a"; }

