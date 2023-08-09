#!/bin/sh

#Start OpenVPN in daemon mode
echo "Starting openvpn"
/usr/sbin/openvpn --config /etc/openvpn/openvpn.ovpn --daemon

#Start tailscale
echo "Starting tailscale"
/usr/local/bin/containerboot
