#!/usr/bin/env bash

# Script made for building the kernel with initramfs
# It will select the kernel selected with "eselect kernel"
cd /usr/src/linux && make clean && make -j$(nproc) && make modules_install install && \
    genkernel --kernel-config=/usr/src/linux/.config --all-ramdisk-modules initramfs && \
    grub-mkconfig -o /boot/grub/grub.cfg && emerge @module-rebuild
