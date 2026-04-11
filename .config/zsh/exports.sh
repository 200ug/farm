# enable gcc colors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# add common binary locations to path (macos specials: /opt/homebrew/bin, /opt/homebrew/sbin)
export PATH="$HOME/.bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:/usr/local/go/bin:$PATH"

# gpg
export GPG_TTY=$(tty) 

