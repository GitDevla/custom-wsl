FROM archlinux:base

ARG USER  

# Install packages
RUN pacman -Sy
RUN yes | pacman -S doas
RUN ln -s /usr/bin/doas /usr/bin/sudo

# Create user
RUN /bin/bash -c 'useradd -m -s /bin/bash -G wheel ${USER}; echo "${USER}:root" | chpasswd'

# Configs
COPY ./wsl.conf /etc/wsl.conf
RUN echo "default=${USER}" >> /etc/wsl.conf
RUN echo "permit nopass :wheel" >> /etc/doas.conf;'

COPY --chown=${USER}:${USER} post-install.sh /home/${USER}/post-install.sh
RUN chmod +x /home/${USER}/post-install.sh

# Distrod
RUN curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh"
RUN chmod +x install.sh
RUN ./install.sh install
RUN /opt/distrod/bin/distrod enable

# Cleanup
RUN rm -rf /var/lib/pacman/sync/*
RUN rm -rf /var/cache/pacman/pkg/*
RUN rm -f /var/log/lastlog