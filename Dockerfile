FROM archlinux:base

ARG USER  

# Install packages
RUN pacman -Sy \ 
 && yes | pacman -S doas \ 
 && ln -s /usr/bin/doas /usr/bin/sudo

# Cache Cleanup
RUN rm -rf /var/lib/pacman/sync/* \
        /var/cache/pacman/pkg/* \
        /var/log/lastlog

# Distrod
RUN curl -L -O "https://raw.githubusercontent.com/nullpo-head/wsl-distrod/main/install.sh" \
 && chmod +x install.sh \
 && ./install.sh install \
 && /opt/distrod/bin/distrod enable

# Create user
RUN useradd -m -s /bin/bash -G wheel ${USER}; echo "${USER}:root" | chpasswd

# Configs
COPY ./wsl.conf /etc/wsl.conf
RUN echo "default=${USER}" >> /etc/wsl.conf
RUN echo "permit nopass :wheel" >> /etc/doas.conf

COPY --chown=${USER}:${USER} post-install.sh /home/${USER}/post-install.sh
RUN chmod +x /home/${USER}/post-install.sh