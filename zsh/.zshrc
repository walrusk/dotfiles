_dotfiles_zshrc="${${(%):-%N}:A}"
export DOTFILES="${DOTFILES:-${_dotfiles_zshrc:h:h}}"
unset _dotfiles_zshrc

if [ -z "${HOMEBREW_PREFIX:-}" ] && command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
elif [ -z "${HOMEBREW_PREFIX:-}" ]; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

typeset -U path PATH
path=(
  "$DOTFILES/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.rbenv/bin"
  $path
)

export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"
export HOMEBREW_NO_ENV_HINTS=1

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt auto_cd
setopt interactive_comments

autoload -Uz compinit
zstyle ':completion:*' menu select
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${_zcompdump:h}"
compinit -d "$_zcompdump"
unset _zcompdump

alias g="git status --short --branch"
alias gc="git commit"
alias gp="git pull"
alias gl="git log --graph --pretty=format:'%C(red)%h%Creset %an: %s %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias d="docker"
alias dc="docker compose"
alias pubkey="pbcopy < ~/.ssh/id_ed25519.pub && echo 'Public key copied to pasteboard.'"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --group-directories-first"
  alias ll="eza -lah --group-directories-first --git"
  alias la="eza -la --group-directories-first"
else
  alias ll="ls -lah"
  alias la="ls -la"
fi

take() {
  mkdir -p "$1" && cd "$1"
}

serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

gco() {
  local branch
  branch="$(git branch --all --sort=-committerdate |
    sed 's/^[* ]*//' |
    grep -v 'HEAD ->' |
    fzf --height=40% --reverse |
    sed 's#^remotes/origin/##')"
  [ -n "$branch" ] && git checkout "$branch"
}

gbd() {
  local branch
  branch="$(git branch --sort=-committerdate |
    sed 's/^[* ]*//' |
    grep -vE '^(main|develop)$' |
    fzf --height=40% --reverse)"
  [ -n "$branch" ] && git branch -d "$branch"
}

fe() {
  local file
  file="$(fd --type f --hidden --follow --exclude .git . | fzf --height=80% --reverse --preview 'bat --style=numbers --color=always --line-range=:500 {} 2>/dev/null')"
  [ -n "$file" ] && "$EDITOR" "$file"
}

fcd() {
  local dir
  dir="$(fd --type d --hidden --follow --exclude .git . | fzf --height=80% --reverse --preview 'eza --tree --level=2 --color=always {} 2>/dev/null')"
  [ -n "$dir" ] && cd "$dir"
}

if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  [ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
  [ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init - zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
