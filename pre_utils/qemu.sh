#!/usr/bin/env bash

# quicker kvm + qemu installer
# check cmd: virsh list --all

sudo systemsudo apt update
sudo apt install -y qemu-system libvirt-clients libvirt-daemon-system virtinst bridge-utils virt-manager

sudo adduser $USER libvirt
sudo adduser $USER kvm

sudo systemctl enable --now libvirtd

echo "[*] log out and back in (or reboot) for the group changes (libvirt & kvm) to take effect"

