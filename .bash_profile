# This file is sourced by any login bash.

# Do everything defined in .bashrc (non-login interactive shells) there as well.
# This also provides the definition of scy_init_{env,path}.
. "$HOME/.bashrc"

# Make sure to not return false, e.g. from the [ -f ] above.
true
