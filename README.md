# walrusk dotfiles

Personal macOS development dotfiles, forked long ago from
[holman/dotfiles](https://github.com/holman/dotfiles).

The current baseline is Apple Silicon-friendly, Homebrew-based, and uses zsh
and Neovim as defaults.

## Install

On a new Mac, install Apple's command line tools first:

```sh
xcode-select --install
```

Then clone and bootstrap:

```sh
git clone https://github.com/walrusk/dotfiles.git ~/repos/dotfiles
cd ~/repos/dotfiles
./bootstrap
```

The bootstrap script will:

- create `git/.gitconfig.local` if needed
- symlink topic dotfiles into `$HOME`
- install Homebrew if it is missing
- run `brew bundle`
- install JetBrainsMono Nerd Font for terminal glyph support
- install Maccy as the clipboard manager
- offer to set `/bin/zsh` as the default login shell
- run topic installers:
  - `bash/install.sh`
  - `macos/install.sh`
  - `nvim/install.sh`
  - `robotnik/install.sh`, including `robotnik` from `github.com/walrusk/robotnik`
  - `ruby/install.sh`
  - `tmux/install.sh`

## Shell

zsh is the default shell configuration. During bootstrap, accept the default
shell prompt to run `chsh -s /bin/zsh`. If `/bin/zsh` is not listed in
`/etc/shells`, bootstrap offers to add it with `sudo` before running `chsh`.

The zsh setup uses:

- `starship` for the prompt
- JetBrainsMono Nerd Font for terminal glyph support
- `fzf`, `fd`, `ripgrep`, `bat`, and `eza` for navigation/search
- `zoxide` instead of the older `z`
- `direnv` when available
- `rbenv` when available

## Editor

Neovim is the default editor:

```sh
echo "$EDITOR"
nvim
```

The Neovim config is linked to `~/.config/nvim` by `nvim/install.sh`. Vim is
left as a minimal fallback only.

## Tools

Bootstrap installs `robotnik` with Go into `~/.local/bin`, which is already on
the default shell `PATH`.

## Layout

- `bin/`: personal command-line helpers added to `$PATH`
- `Brewfile`: Homebrew bundle for the baseline development stack
- `topic/install.sh`: topic installers run by `./bootstrap`
- `topic/.*`: dotfiles symlinked into `$HOME`
- `nvim/config/`: Neovim configuration linked to `~/.config/nvim`

## Notes

The bootstrap deliberately does not run macOS software updates automatically.
Run this manually when you are ready:

```sh
softwareupdate --install --all
```
