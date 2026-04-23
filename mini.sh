#!/usr/bin/env bash

# barebones packages and other things to get stuff up and running (mostly just trixie compatibility right now)

set -euo pipefail

die() { echo "[!] error: $*" >&2; exit 1; }

require_cmd() {
    command -v "$1" &>/dev/null || die "'$1' required but not found in PATH"
}

configure_brave_repo() {
    # https://brave.com/linux/
    require_cmd curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
}

configure_mullvad_repo() {
    # https://mullvad.net/en/download/vpn/linux
    require_cmd curl
    sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
    echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
}

configure_signal_repo() {
    # https://signal.org/download/#
    require_cmd wget
    require_cmd gpg
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
    cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
    wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
    cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
    rm -f signal-desktop-keyring.gpg signal-desktop.sources
}

linux_install() {
    # web versions preferred over bins: telegram, tuta

    local apt_pkgs=(
        # gui apps
        libreoffice
        keepassxc
        qbittorrent
	    alacritty
        # gui apps from vendor repos
        mullvad-vpn
        signal-desktop
        brave-browser
        # terminal base toolings
        zsh
        fd-find                 # fd is /usr/bin/fdfind on debian
        ripgrep
        zsh-autosuggestions
        fzf
        gnupg
        scdaemon                # required for hardware keys
        # neovim                # apt's neovim is too old, we should install it from https://github.com/neovim/neovim/releases/
        tmux
        # misc
        ffmpeg
        mpv
        stow
        podman
        podman-compose
        rsync
        tree
        git
        btop
        libimage-exiftool-perl  # provides "exiftool"
        subliminal
        yt-dlp
    )

    configure_brave_repo
    configure_mullvad_repo
    configure_signal_repo

    # TODO: add feather wallet (https://featherwallet.org/download/)

    sudo apt update

    install_veracrypt_deb
    install_neovim_release

    sudo apt install -y ca-certificates curl wget gnupg apt-transport-https
    sudo DEBIAN_FRONTEND=noninteractive apt install -y "${apt_pkgs[@]}" || echo "[!] general package installation failed"
}

install_veracrypt_deb() {
    require_cmd curl
    local tmpdeb=$(mktemp --suffix=.deb)
    curl -fsSL https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-console-1.26.24-Debian-13-amd64.deb -o $tmpdeb
    sudo DEBIAN_FRONTEND=noninteractive apt install -y $tmpdeb || echo "[!] veracrypt deb installation failed"
    rm -f $tmpdeb
}

install_neovim_release() {
    require_cmd curl
    local tmpdir=$(mktemp -d)
    curl -Lo $tmpdir/nvim-linux-arm64.tar.gz https://github.com/neovim/neovim/releases/download/v0.12.1/nvim-linux-arm64.tar.gz
    tar -xzf $tmpdir/nvim-linux-arm64.tar.gz -C "$tmpdir/"
    mkdir -p ~/.local/
    cp -r $tmpdir/nvim-linux-arm64/* ~/.local/
    rm -rf $tmpdir
}

linux_install

