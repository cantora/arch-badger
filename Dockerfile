FROM cantora/arch

RUN mkdir /root/docker-build/
ADD ./setup.tar.gz /root/docker-build/
RUN rm -f /root/docker-build/*.sig
RUN pacman-key --init
RUN pacman --config /dev/null \
           --noconfirm -U  /root/docker-build/blackarch-keyring.pkg.tar.xz
RUN printf '\n[blackarch]\nServer = %s/$repo/os/$arch\n' \
              'http://mirror.jmu.edu/blackarch/' \
           >> /etc/pacman.conf

RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm sudo gdb git tree sudo make gcc screen emacs-nox openbsd-netcat
RUN pacman -S --noconfirm wfuzz sqlmap

RUN groupadd sudo
RUN printf '\n%%sudo   ALL=(ALL) ALL\n' >> /etc/sudoers
#ensure the password file isnt empty
RUN if diff /dev/null /root/docker-build/pass.txt >/dev/null 2>&1; then false; else true; fi
RUN useradd -G sudo -m qwer -p "$(cat /root/docker-build/pass.txt)" && rm /root/docker-build/pass.txt

USER qwer
WORKDIR /home/qwer
ENV HOME /home/qwer
ENV SHELL /bin/bash
RUN mkdir install
WORKDIR /home/qwer/install
RUN git clone 'https://github.com/cantora/cantora-bin.git'
RUN cd cantora-bin && make install
RUN git clone 'https://github.com/cantora/rc.git'
RUN cd rc && make install
