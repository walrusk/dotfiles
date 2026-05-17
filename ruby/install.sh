#!/usr/bin/env bash

set -euo pipefail

if ! command -v rbenv >/dev/null 2>&1; then
  echo "rbenv not found; skipping Ruby install."
  exit 0
fi

eval "$(rbenv init - bash)"

ruby_version="${RUBY_VERSION:-}"
if [ -z "$ruby_version" ]; then
  ruby_version="$(
    rbenv install -l |
      grep -E '^[[:space:]]*[0-9]+\.[0-9]+\.[0-9]+$' |
      tail -n 1 |
      tr -d '[:space:]'
  )"
fi

if [ -z "$ruby_version" ]; then
  echo "Could not determine latest stable Ruby version."
  exit 1
fi

rbenv install "$ruby_version" --skip-existing
rbenv global "$ruby_version"
rbenv rehash
rbenv versions
