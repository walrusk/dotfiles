#!/usr/bin/env bash

set -euo pipefail

if ! command -v git >/dev/null 2>&1; then
  echo "git not found; skipping tmux plugin manager install."
  exit 0
fi

tpm_dir="$HOME/.tmux/plugins/tpm"

if [ -d "$tpm_dir/.git" ]; then
  echo "tmux plugin manager already installed."
else
  mkdir -p "$(dirname "$tpm_dir")"
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

echo "Inside tmux, press prefix + I to install tmux plugins."
