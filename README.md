# tailscale-proxy

Setup a [Tailscale Exit Node](https://tailscale.com/kb/1103/exit-nodes/) to act as a VPN proxy.

## Summary
Creates a container with OpenVPN and Tailscale that,

- Connects to OpenVPN using embedded configuraiton
- Connects to Tailscale using Authkey
- Advertises as an Exit Node on your Tailnet

Enabling as an Exit Node in Tailscale admin console will allow the container to act as a proxy forwarding all traffic over the VPN. This allows funneling all traffic through different locations like Europe or Asia.

## Howto

### Tailscale Authentication

Create a [Tailscale Auth Key](https://tailscale.com/kb/1085/auth-keys/) and update the [`TS_AUTHKEY`](https://tailscale.com/kb/1282/docker/#ts_authkey) ENV variable in `docker-compose.yml`.

### VPN Configuration

Put a valid [OpenVPN configuration file](https://openvpn.net/community-resources/creating-configuration-files-for-server-and-clients/) for your VPN of choice in the same directory as the `docker-compose.yml` and name it `openvpn.ovpn`.

### Building

Build the docker image with `docker compose build`

### Running

Run the container with `docker compose up`

This will connect to the VPN and Tailscale, advertising itself as an Exit Node. You may need to go into your Tailscale account and verify/enable the container on the Tailnet as an Exit Node.

### Testing

Shell into the running tailscale container with `docker compose exec -it proxy` and verify the IP returned with `curl https://ifconfig.co` is your VPN IP.

On another device on your Tailnet, use the new `proxy` device as the Exit Node and verify https://ifconfig.co is returning your VPN IP.
