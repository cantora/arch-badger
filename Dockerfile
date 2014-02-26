FROM cantora/arch

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm sudo gdb git tree

RUN mkdir /root/docker-build/

ADD ./setup.tar.gz /root/docker-build/
RUN rm -f /root/docker-build/*.sig
RUN pacman-key --init
RUN pacman --config /dev/null \
           --noconfirm -U  /root/docker-build/blackarch-keyring.pkg.tar.xz
RUN printf '\n[blackarch]\nServer = %s/$repo/os/$arch\n' \
              'http://mirror.jmu.edu/blackarch/' \
           >> /etc/pacman.conf
RUN pacman -Syyu
