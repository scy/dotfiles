#!/bin/sh

msg() {
	printf '%s: %s\n' 'wsl-gpg-agent' "$*"
}

die() {
	msg "$*" >&2
	exit 1
}

which socat >/dev/null || die 'socat is not in $PATH'
which npiperelay.exe >/dev/null || die 'npiperelay.exe is not in $PATH'

win_gpg_dir="$(cmd.exe /c echo %APPDATA% 2>/dev/null | tr \\\\ / | tr -d '\r')/gnupg"
win_gpg_socket="$win_gpg_dir/S.gpg-agent"
wsl_gpg_socket="$(gpgconf --list-dirs agent-socket)"

msg "$wsl_gpg_socket" '-->' "$win_gpg_socket"
socat "UNIX-LISTEN:$wsl_gpg_socket,fork" "EXEC:npiperelay.exe -ei -ep -s -a \"$win_gpg_socket\",nofork"
