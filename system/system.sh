#!/bin/bash

set -e

MYDIR=/root/docker-build/system

rm -f $MYDIR/blackarch-keyring.pkg.tar.xz.sig
pacman-key --init
pacman --config /dev/null \
       --noconfirm -U $MYDIR/blackarch-keyring.pkg.tar.xz
printf '\n[blackarch]\nServer = %s/$repo/os/$arch\n' \
         'http://mirror.jmu.edu/blackarch/' \
       >> /etc/pacman.conf

pacman -Syyu --noconfirm
ARCH_UTILS="sudo gdb git tree sudo make gcc screen emacs-nox openbsd-netcat php socat"
BLACKARCH_UTILS="wfuzz sqlmap"
pacman -S --noconfirm $ARCH_UTILS $BLACKARCH_UTILS
