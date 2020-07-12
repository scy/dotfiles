#!/bin/sh

msg() {
	printf '%s: %s\n' 'wsl-gpg-agent' "$*"
}

die() {
	msg "$*" >&2
	exit 1
}

socket_alive() {
	# We can't use [ -S ] here because Unix sockets in the Windows filesystem don't look like sockets to WSL (ikr).
	[ -e "$1" ] && socat -u OPEN:/dev/null "UNIX-CONNECT:$1" 2>/dev/null
}

which socat >/dev/null || die 'socat is not in $PATH'
which npiperelay.exe >/dev/null || die 'npiperelay.exe is not in $PATH'
which wsl-ssh-pageant.exe >/dev/null || die 'wsl-ssh-pageant.exe is not in $PATH'

win_gpg_dir="$(cmd.exe /c echo %APPDATA% 2>/dev/null | tr \\\\ / | tr -d '\r')/gnupg"
win_gpg_socket="$win_gpg_dir/S.gpg-agent"
win_ssh_socket="$win_gpg_dir/S.wsl-ssh-pageant"
wsl_gpg_socket="$(gpgconf --list-dirs agent-socket)"
wsl_ssh_socket="$(wslpath -a "$win_ssh_socket")"

msg "$wsl_gpg_socket" '-->' "$win_gpg_socket"
socket_alive "$wsl_gpg_socket" || rm -f "$wsl_gpg_socket"
socat "UNIX-LISTEN:$wsl_gpg_socket,fork" "EXEC:npiperelay.exe -v -ei -ep -a \"$win_gpg_socket\",nofork" &

msg "$wsl_ssh_socket" '-->' "$win_ssh_socket"
# Check whether somebody is listening at the wsl-ssh-pageant socket. If not, delete it (else wsl-ssh-pageant won't start) and start wsl-ssh-pageant.
if ! socket_alive "$wsl_ssh_socket"; then
	rm -f "$wsl_ssh_socket"
	wsl-ssh-pageant.exe -verbose -wsl "$win_ssh_socket"
fi
