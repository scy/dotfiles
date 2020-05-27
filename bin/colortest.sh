#!/bin/sh
# Yet Another Color Table Script
# by Tim Weber, https://github.com/scy/dotfiles

#  $1  color number
color_name() {
	case "$1" in
		0) echo 'black';;
		1) echo 'red';;
		2) echo 'green';;
		3) echo 'yellow';;
		4) echo 'blue';;
		5) echo 'magenta';;
		6) echo 'cyan';;
		7) echo 'white';;
		9) echo 'default';;
		*) printf '%s\n' "$1";;
	esac
}

#  $1  background color (0-7 or 9 for "default")
#  $2  base foreground color (0-7 or 9 for "default")
#  $3  "bold" or "bright" flag (1 for "on", anything else for "off")
print_cell() {
	code="3${2};4${1}"
	[ "$3" = '1' ] && code="1;$code"
	printf '\033[%sm %7s \033[0m ' "$code" "$code"
}

#  $1  base foreground color for this line (0-7 or 9 for "default")
#  $2  "bold" or "bright" flag (1 for "on", anything else for "off")
print_line() {
	name="$(color_name "$1")"
	one=''
	[ "$2" = '1' ] && name="bold $name" && one='1;'
	printf '\033[%s3%d;49m%12s\033[0m  ' "$one" "$1" "$name"
	for bg in 9 0 1 2 3 4 5 6 7; do
		print_cell "$bg" "$1" "$2"
	done
}

# Header line.
printf '%12s  '  # space for color name column
for color in 9 0 1 2 3 4 5 6 7; do
	printf '\033[3%d;49m %7s \033[0m ' "$color" "$(color_name "$color")"
done
printf '\n'

# Actual color table.
for bold in '' 1; do
	for fg in 9 0 1 2 3 4 5 6 7; do
		print_line "$fg" "$bold"
		printf '\n'
	done
done
