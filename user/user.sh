#!/bin/bash

set -e

HOME=/home/qwer
cd $HOME
mkdir install
cd /home/qwer/install
git clone 'https://github.com/cantora/cantora-bin.git'
bash -c 'cd cantora-bin && make install'
git clone 'https://github.com/cantora/rc.git'
bash -c 'cd rc && make install'
