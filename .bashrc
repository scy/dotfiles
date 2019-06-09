# This file will be sourced by every interactive bash and, since it's sourced in ~/.bash_profile, also by login bashes.

FISHCONF="$HOME/.config/fish/conf.d"

# Load simple aliases. It's a fish file, but I've designed it to be bash compatible.
. "$FISHCONF/aliases.fish"

# The umask setting is bash-compatible as well.
. "$FISHCONF/umask.fish"

# Get $PATH from the fish config file. The `eval` call is required to resolve variables in the result (e.g. $HOME).
scy_init_path() {
	# Since printf will repeat the format string if there are multiple parameters, this automatically deals with
	# fish using spaces to separate the directories.
	export PATH="$(eval printf '%s:' $(sed -n -e 's/^set -U fish_user_paths //p' "$FISHCONF/path.fish"))$PATH"
}

# Load environment variables from the fish config. We need to do some basic replacement to make it work in bash.
scy_init_env() {
	eval $(sed -n -e 's/^set -gx \([^ ]*\) /export \1=/p' "$FISHCONF/env.fish")
}

# Edit a shell config file and then reload it. Some special cases for fish configs.
edit_and_source() {
	edit "$1"
	rc="$?"
	if [ "$rc" -ne 0 ]; then
		return "$rc"
	fi
	case "$1" in
		*/env.fish)
			scy_init_env
			;;
		*/path.fish)
			scy_init_path
			;;
		*)
			. "$1"
			;;
	esac
}
