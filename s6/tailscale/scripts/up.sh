#!/bin/sh

# This is essentially a workaround to get Environment Variable Substitution
# working with s6-overlay.
# This is stated near the end of the "Moving to v3" instructions:
# https://github.com/just-containers/s6-overlay/blob/29a53859e7f9bd89d7c8a2f01354f8725a215bd2/MOVING-TO-V3.md#service-management-related-changes

tailscale up --authkey=${TAILSCALE_AUTH_KEY} --hostname=fly-hole --accept-dns=false
