FROM voidlinux/voidlinux-musl

# Install bash
RUN xbps-install -Suy bash curl xz unzip make git patch

# Configure git
RUN git config --global user.email "foo@bar.com"
RUN git config --global user.name "linux-install-mklive"

# Copy script
RUN mkdir -p /opt/mkiso

COPY scripts/ /opt/mkiso/scripts/
COPY patches/ /opt/mkiso/patches/

CMD /opt/mkiso/scripts/mkiso.sh

