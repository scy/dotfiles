# This file is sourced by any login bash.

# Do everything defined in .bashrc (non-login interactive shells) there as well.
# This also provides the definition of scy_init_{env,path}.
. "$HOME/.bashrc"

# This is explicitly _not_ done from .bashrc, because simple interactive bash shells are expected to be started by
# either fish or a login bash; both will export this setting to them already.
scy_init_path

# Same reasoning as above for putting it here instead of in .bashrc applies.
scy_init_env

# Make sure to not return false, e.g. from the [ -f ] above.
true
