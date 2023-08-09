FROM public.ecr.aws/debian/debian:bookworm-slim
WORKDIR /app

#Install curl and ca certs
RUN apt-get update && apt-get install -y curl ca-certificates

#Add Tailscale Repos
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.noarmor.gpg | tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null \
    && curl -fsSL https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list | tee /etc/apt/sources.list.d/tailscale.list

#Install openvpn and tailscale
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openvpn \
        tailscale

#Copy tailscale binary from official tailscale container
COPY --from=tailscale/tailscale /usr/local/bin/containerboot /usr/local/bin/containerboot

#Copy local entyrpoint
COPY --chmod=0755 entrypoint.sh .

ENTRYPOINT /app/entrypoint.sh
