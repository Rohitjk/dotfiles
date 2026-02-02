# --- Zsh basics ---
setopt autocd
setopt correct
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt hist_ignore_all_dups
setopt share_history

# --- Homebrew prefix (avoid repeated calls) ---
BREW_PREFIX="$(brew --prefix)"

# --- Homebrew completions (must be before compinit) ---
fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)

# --- Completions (fast init) ---
autoload -Uz compinit
compinit -C   # use cached compdump if possible

# --- fzf (installed via `$(brew --prefix)/opt/fzf/install`) ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Optional: fzf UI defaults
export FZF_DEFAULT_OPTS="
--height 40%
--layout=reverse
--border
--inline-info
"
# --- fzf: use fd instead of find ---
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- Conda ---
# >>> conda initialize >>>
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# --- Git aliases (OMZ-like) ---
alias gst='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gl='git pull'
alias gp='git push'
alias gaa='git add --all'
alias gcm='git commit -m'
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'


# --- Yazi ---
# Basic alias
alias yy='yazi'

# yazi with cd-on-exit (recommended)
function y() {
  local tmp="/tmp/yazi-cwd"
  command yazi --cwd-file="$tmp" "$@"
  if [[ -f "$tmp" ]]; then
    local dir
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [[ -n "$dir" ]] && cd "$dir"
  fi
}

# Optional: fzf → yazi on selected path
alias yf='yazi "$(fzf)"'

# --- Extra PATHs ---
# LM Studio CLI (lms)
export PATH="$PATH:/Users/rohitjayakrishnan/.lmstudio/bin"

# --- Zsh plugins ---
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Must be last plugin
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# --- Starship prompt (keep last) ---
eval "$(starship init zsh)"
