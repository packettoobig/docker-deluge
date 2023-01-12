#!/usr/bin/env bash

# run as root
if [ 0 -eq "$PUID" ] || [ 0 -eq "$PGID" ]; then
	exec "$@"
fi

export USERHOME="/home/$USERNAME"

getent group "$PGID" || addgroup "$GROUPNAME" --gid "$PGID"
getent passwd "$PUID" || adduser "$USERNAME" --uid "$PUID" --gid "$PGID" --gecos "" --home "$USERHOME" --disabled-password
mkdir -p "$USERHOME"
chown -R "$PUID:$PGID" "$USERHOME"

# run as normal user
# exec sudo -u "#$PUID" -g "#$PGID" -HD "$USERHOME" --non-interactive --preserve-env "$@"
# exec sudo -u "$USERNAME" -g "$GROUPNAME" -HD "$USERHOME" --non-interactive --preserve-env "$@"
exec sudo -u "$USERNAME" -g "$GROUPNAME" -H --non-interactive --preserve-env "$@"