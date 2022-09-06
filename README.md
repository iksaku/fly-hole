# Fly-hole

This is an attempt to run Pi-hole with Tailscale in the Fly.io network, however, a big roadblock showed:

- Pi-hole base image uses s6-overlay for service interfacing, which is great for customization, however,
fly.io also fights for PID 1 as s6, so s6 will crash.