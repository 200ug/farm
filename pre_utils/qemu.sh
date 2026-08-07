#!/usr/bin/env bash

# quicker kvm + qemu installer
# check cmd: virsh list --all

sudo systemsudo apt update
sudo apt install -y qemu-system libvirt-clients libvirt-daemon-system virtinst bridge-utils virt-manager
sudo usermod -aG libvirt $USER && sudo usermod -aG kvm $USER
sudo systemctl enable --now libvirtd

echo "[*] log out and back in (or reboot) for the group changes (libvirt & kvm) to take effect"

