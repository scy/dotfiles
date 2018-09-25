# This makes sure that fish_user_abbreviations is not a universal variable, which allows me to manage it in an automated way.
# The file name starts with an underscore to make sure it's sourced before any other snippets.
if status --is-interactive
	set -g fish_user_abbreviations
end
