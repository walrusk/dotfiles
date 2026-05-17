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
- run topic installers

## Shell

zsh is the default shell configuration. After bootstrap, make Homebrew zsh your
login shell if it is not already:

```sh
chsh -s "$(brew --prefix)/bin/zsh"
```

The zsh setup uses:

- `starship` for the prompt
- `fzf`, `fd`, `ripgrep`, `bat`, and `eza` for navigation/search
- `zoxide` instead of the older `z`
- `direnv` when available
- `rbenv` when available

Bash is still configured as a small compatibility profile, but it no longer
installs Bash-it.

## Editor

Neovim is the default editor:

```sh
echo "$EDITOR"
nvim
```

The Neovim config is linked to `~/.config/nvim` by `nvim/install.sh`. Vim is
left as a minimal fallback only.

## Containers

Docker Desktop is not installed by default. The Brewfile installs the Docker
CLI plus Colima:

```sh
colima start
docker context use colima
```

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
