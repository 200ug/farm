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
alias vera-mount="veracrypt /media/solar/KNGSTN-A/zurich /mnt/zmount"
alias vera-umount="veracrypt --text --dismount /mnt/zmount && umount /media/solar/KNGSTN-A"

