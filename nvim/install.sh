#!/usr/bin/env bash

set -euo pipefail

if [ -n "${DOTFILES_ROOT:-}" ]; then
  root="$DOTFILES_ROOT"
else
  root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null 2>&1 && pwd -P)"
fi

src="$root/nvim/config"
dst="$HOME/.config/nvim"

mkdir -p "$HOME/.config"

if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
  echo "Neovim config already linked."
  exit 0
fi

if [ -e "$dst" ] || [ -L "$dst" ]; then
  backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
  mv "$dst" "$backup"
  echo "Moved existing Neovim config to $backup"
fi

ln -s "$src" "$dst"
echo "Linked Neovim config to $dst"
