# typo handlers
alias vim="nvim"
alias vi="nvim"
alias gitst="git st"

# overwrite confirmations
alias mv="mv -i"
alias cp="cp -i"

# tool shortcuts
alias l="ls -lah --color=auto"
alias ls="ls --color=auto -hv"
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -c=auto"
alias exifstrip="exiftool -all="
alias decrypt-msg="gpg -d msg.tmp | nvim -R -"
alias mvstat="mullvad status -v"
alias mvcon="mullvad connect"
alias mvdisc="mullvad disconnect"
alias mvres="mullvad reconnect"
alias pwdcp="pwd | wl-copy"

# net address aliases
alias getipv4="curl -s4 https://ip.antti.codes/"
alias getipv6="curl -s6 https://ip.antti.codes/"

# veracrypt (console build, cli-only)
# alias veracrypt="/usr/bin/veracrypt -t"
# alias vera-mount="/usr/bin/veracrypt -t /dev/disk/by-label/KNGSTN-A/zurich /mnt/zmount"
# alias vera-umount="/usr/bin/veracrypt -t -u /mnt/zmount && sudo umount /dev/disk/by-label/KNGSTN-A"
