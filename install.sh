#!/bin/sh
# Link the herdr and tmux configs from this repo into place.
# Run after cloning to ~/.config/nvim. Existing files are kept as *.bak.
set -e
repo="$(cd "$(dirname "$0")" && pwd)"

link() {
	mkdir -p "$(dirname "$2")"
	if [ -e "$2" ] && [ ! -L "$2" ]; then mv "$2" "$2.bak"; fi
	ln -sfn "$1" "$2"
	echo "$2 -> $1"
}

link "$repo/herdr/config.toml" "$HOME/.config/herdr/config.toml"
link "$repo/tmux/.tmux.conf" "$HOME/.tmux.conf"
