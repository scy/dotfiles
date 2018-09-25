# Every line starting with `set -gx` in this file will be loaded from .bash_profile as well, so stay compatible.

# My script to find a sensible editor.
set -gx EDITOR "$HOME/bin/edit"
set -gx VISUAL "$EDITOR"
