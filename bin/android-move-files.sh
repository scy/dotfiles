#!/bin/sh
set -e

# This script moves files around on my Android phone. It's supposed to be called at regular intervals.

AUDIOREC='storage/shared/Android/data/com.github.axet.audiorecorder/files/recordings'

# Make sure the necessary paths are there.
cd "$HOME"
if ! [ -e storage ]; then
	printf "initialize storage first\n" >&2
	exit 1
fi
[ -e my ] || ln -s /storage/emulated/0/my my

# Audio recordings should be copied from the recorder app to the "inbox" directory. Once they're removed from the inbox
# (i.e. I've dealt with them), they should be removed from the recorder app as well.
if [ -d "$AUDIOREC" ]; then
	mkdir -p my/ib/rec
	cd "$AUDIOREC"
	for f in *.*; do
		if [ "$f" = "${f#ib.}" ]; then
			# Files that are not yet prefixed "ib." should be copied to the inbox.
			cp -p "$f" "$HOME/my/ib/rec"
			mv "$f" "ib.$f"
		else
			# Files that are already prefixed, but _not_ in the inbox anymore, should be assumed to be handled and thus
			# removed from their original location too.
			[ ! -e "$HOME/my/ib/rec/${f#ib.}" ] && rm "$f"
		fi
	done
	cd - > /dev/null
fi
