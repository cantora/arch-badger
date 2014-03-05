#!/bin/bash

set -e

MYDIR=/root/docker-build/config

groupadd sudo
printf '\n%%sudo   ALL=(ALL) ALL\n' >> /etc/sudoers
#ensure the password file isnt empty
if diff /dev/null $MYDIR/pass.txt >/dev/null 2>&1; then
  exit 1
fi
useradd -G sudo -m qwer -p "$(cat $MYDIR/pass.txt)" \
  && rm $MYDIR/pass.txt
