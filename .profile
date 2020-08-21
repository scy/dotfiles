# ~/.profile is designed to be a shell-independent configuration after login.
# For now, I'm just using it to load my .bashrc, if the shell is indeed bash.

# Without a .profile file, bash would do that by itself, but Debian systems
# come with a .profile in their user skeleton directories. Since the setup
# procedure of my dotfiles repo does not remove existing files that are not in
# the repo, it was usually left lying around and spammed my `git status`.
# Therefore, I've added a .profile to the repo. :shrug:

[ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
