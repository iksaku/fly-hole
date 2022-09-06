FROM pihole/pihole:latest

ARG S6_DIR=/etc/s6-overlay/s6-rc.d

# Setup Pi-hole to listen on tailscale interface
ENV INTERFACE=tailscale0
ENV DNSMASQ_LISTENING=ALL

# Setup Pi-hole environment variables
ENV TZ=America/Chicago
ENV PIHOLE_DNS=1.1.1.1;1.0.0.1

# Prepare Pi-hole data to be mapped to mounted Fly volume
RUN mkdir -p /mnt/data \
    && ln -s /etc/pihole /mnt/data/pihole \
    && ln -s /etc/dnsmasq.d /mnt/data/dnsmasq.d

# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Setup Tailscale Daemon Service
COPY s6/tailscaled ${S6_DIR}/tailscaled
RUN touch ${S6_DIR}/user/contents.d/tailscaled
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

# Setup Tailscale Connections
COPY s6/tailscale ${S6_DIR}/tailscale
RUN touch ${S6_DIR}/user/contents.d/tailscale \
    && chmod +x -R ${S6_DIR}/tailscale/scripts

# Start Tailscale first, then Pi-hole
RUN mkdir -p ${S6_DIR}/pihole-FTL/dependencies.d \
    && touch ${S6_DIR}/pihole-FTL/dependencies.d/tailscale