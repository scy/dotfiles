# If this is a login shell and autoborg is configured, show a reminder if the
# last rsync of the backup repo was too long ago.

status is-login >/dev/null; and [ -r "$HOME/.autoborg/config.sh" ]; and borg rsync-reminder
