# For each Git alias defined in .gitconfig, create a corresponding shell abbreviation, prefixed with `g`.
# For example, the Git alias `s` for `status` will be available as `git s`, but also as `gs`.
function scy_init_git_abbreviations -d 'Create fish abbreviations for Git aliases'
	# Remove all abbreviations that start with `g`.
	for line in (abbr -l | sed -n -e 's/^\(g[^ ]*\).*$/\1/p')
		abbr --erase $line
	end
	# Create one for each alias.
	abbr --add g git
	for line in (git config --global --get-regexp '^alias\.' | sed -e 's/^alias\.//')
		set -l split (string split -m 1 ' ' $line)
		abbr --add g$split[1] git $split[2]
	end
end
scy_init_git_abbreviations

# Define a command to edit and reload the aliases.
function gited -d 'Edit Git config and update the shell abbreviations'
	edit "$HOME/.gitconfig"
	scy_init_git_abbreviations
end
