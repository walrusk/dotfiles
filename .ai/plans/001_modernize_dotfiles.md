# Modernize Dotfiles

## Goal

Make this dotfiles project reliable for development on the current Apple Silicon Mac and a new company Mac in 2026.

## Scope

- Modernize defaults from Bash/Vim to zsh/Neovim and remove legacy Bash profile support.
- Update bootstrap and installers for current Homebrew, Apple Silicon paths, safer shell behavior, and repeatable fresh-machine setup.
- Refresh the Homebrew bundle to a smaller modern baseline.
- Remove approved stale artifacts and older baseline tools:
  - `bin/ngrok`
  - `bin/subl`
  - `bin/tmuxinator`
  - `tmux/robotnorman.yml`
  - `php`
  - `composer`
  - `ack`
  - `z`
  - `spaceman-diff`
  - `google-cloud-sdk`
  - `kubernetes-cli`
  - Docker Desktop
- Update shell, tmux, git, editor, and documentation to match the new baseline.

## Validation

- Run syntax checks for shell scripts.
- Run `brew bundle check --file Brewfile` to verify Brewfile parsing and current-machine state.
- Run targeted smoke checks for config files where available.
