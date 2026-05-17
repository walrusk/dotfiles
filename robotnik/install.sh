#!/usr/bin/env bash

set -euo pipefail

if ! command -v go >/dev/null 2>&1; then
  echo "go not found; cannot install Robotnik."
  exit 1
fi

bin_dir="$HOME/.local/bin"
mkdir -p "$bin_dir"

GOBIN="$bin_dir" go install github.com/walrusk/robotnik@latest

if [ -x "$bin_dir/robotnik" ]; then
  echo "Installed robotnik to $bin_dir/robotnik"
else
  echo "Robotnik install completed, but $bin_dir/robotnik was not found."
  exit 1
fi
