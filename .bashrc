# This file will be sourced by every interactive bash and, since it's sourced in ~/.bash_profile, also by login bashes.

# First, if there's a global bashrc, load it.
[ -f /etc/bashrc ] && . /etc/bashrc

# Default umask is 0022, i.e. write permissions only for the user, not the group.
# Some OSes have different defaults; this defines a standard for all of my machines.
umask 0022

# Automatically change into directories (without `cd`), and fail commands when nothing matches a glob.
shopt -s autocd failglob

# Don't store lines starting with a space in the history, or lines identical to the one before.
HISTCONTROL='ignorespace:ignoredups'

# Set a custom PATH by modifying the default one. However, keep a copy of the default one in order to not keep prefixing
# it when nesting shells etc.
[ -z "$MASTERPATH" ] && export MASTERPATH="$PATH"
export PATH="$HOME/bin:$HOME/.local/bin:$MASTERPATH"

# ls aliases.
# Arguments common to every ls alias. Only use `--color` if ls actually supports that parameter.
alias ls="ls -F$(ls --color=auto "$HOME" >/dev/null 2>&1 && printf ' %s' '--color=auto')"
# List all (a), long format (l, one per line) and a combination of both.
alias a='ls -a' l='ls -lh' la='l -a'
# List by time. Also some combinations for reversing and combining with -a.
alias lt='l -t' ltr='lt -r' lta='lt -a' lat='lta' ltar='lta -r' latr='ltar'
# List by size. Same combinations as above.
alias lz='l -S' lzr='lz -r' lza='lz -a' laz='lza' lzar='lza -r' lazr='lzar'

# I have a script that chooses the "best" editor available on the system.
export EDITOR="$HOME/bin/edit"
export VISUAL="$EDITOR"

# Talk English to me.
export LANG='en_US.UTF-8'

# Reloading .bashrc.
alias rc=". '$HOME/.bashrc'"

# For each Git alias defined in .gitconfig, create a corresponding shell alias, prefixed with `g`.
# For example, the Git alias `s` for `status` will be available as `git s`, but also as `gs`.
# This line, by design, doesn't throw errors when Git is not installed.
eval alias g='git' $(git config --global --get-regexp '^alias\.' 2>/dev/null | sed -e 's/^alias\.\([^ ]*\) .*$/g\1='"'g \1'/")

# Editor.
alias e='edit'
alias erc="edit '$HOME/.bashrc'; rc"
alias egit="edit '$HOME/.gitconfig'; rc" # source bashrc since Git aliases could have been updated

# If an alias value ends in a space, the following word is alias-expanded, too.
# So, this will allow you to use your aliases even when passing them to sudo:
alias sudo='sudo '

# Diagnostics.
alias 1='ping 1.1.1.1'
alias 8='ping 8.8.8.8'

# A simple prompt.
# I'm using $HOSTNAME instead of \h so that it can be overridden, e.g. by a
# local bashrc.
PS1='\n\[\e[0;32m\][\[\e[1;30m\]\t\[\e[0;32m\]]\[\e[0m\] \u\[\e[1;30m\]@\[\e[0m\]$HOSTNAME\[\e[1;34m\] \w \[\e[0;33m\]#\!\[\e[1;32m\] \$ \[\e[0m\]'
# With `set -x`, print a timestamp before printing the command.
PS4='\[\e[0;32m\][\[\e[1;30m\]\t\[\e[0;32m\]]\[\e[0m\] '

# Source a local bashrc, if it exists.
[ -f "$HOME/.bashrc.local" ] && . "$HOME/.bashrc.local"
