# Bash compatibility profile. The default interactive shell is zsh.

_dotfiles_profile="${BASH_SOURCE[0]}"
while [ -L "$_dotfiles_profile" ]; do
  _dotfiles_dir="$(cd -P "$(dirname "$_dotfiles_profile")" >/dev/null 2>&1 && pwd)"
  _dotfiles_profile="$(readlink "$_dotfiles_profile")"
  [[ "$_dotfiles_profile" != /* ]] && _dotfiles_profile="$_dotfiles_dir/$_dotfiles_profile"
done
export DOTFILES="${DOTFILES:-$(cd -P "$(dirname "$_dotfiles_profile")/.." >/dev/null 2>&1 && pwd)}"
unset _dotfiles_profile _dotfiles_dir

if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

export PATH="$DOTFILES/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.rbenv/bin:$PATH"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

alias g="git status --short --branch"
alias ll="ls -lah"
alias vim="nvim"
alias vi="nvim"

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - bash)"
