# This file is sourced by any login bash.

# Get $PATH from the fish config file. The `eval` call is required to resolve variables in the result (e.g. $HOME).
# This is explicitly _not_ done from .bashrc, because simple interactive bash shells are expected to be started by
# either fish or a login bash; both will export this setting to them already.
export PATH="$(eval printf '%s:' $(sed -n -e 's/^set -U fish_user_paths //p' "$HOME/.config/fish/conf.d/path.fish"))$PATH"

# Load environment variables from the fish config as well. We need to do some basic replacement to make it work in bash.
# Same reasoning as above for putting it here instead of in .bashrc applies.
eval $(sed -n -e 's/^set -gx \([^ ]*\) /export \1=/p' "$HOME/.config/fish/conf.d/env.fish")

# If there's a .bashrc for interactive (non-login) shells, do everything defined in there as well.
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Make sure to not return false, e.g. from the [ -f ] above.
true
