# If this is a login shell and autoborg is configured, do some autoborg things.

if status is-login >/dev/null; and [ -r "$HOME/.autoborg/config.sh" ]
	# On WSL, start the cron service if it's not already running.
	if grep -q Microsoft /proc/version ^/dev/null; and not service cron status >/dev/null
		sudo -n service cron start
	end
	# Remind me if the most recent rsync was too long ago.
	borg rsync-reminder
end
