export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=0
if [[ -r /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

alias ls="eza -a --icons --git --group-directories-first"

if [[ -r /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

if (( $+commands[fzf] )); then
  if (( $+commands[fzf] )); then
    source <(fzf --zsh)
  fi
  [[ -r ~/.fzf.zsh ]] && source ~/.fzf.zsh
fi

# alias for zoxide
if (( $+commands[z] )); then
  alias cd='z'
fi

# keybind for tmux-sessionizer script
bindkey -s '^[t' "tmux-sessionizer\n"

if [[ -d /usr/lib/jvm/default-java/bin ]]; then
  export PATH="/usr/lib/jvm/default-java/bin:$PATH"
fi

[[ -r "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ -r "$HOME/.dotfiles/.env" ]]; then
 set -a
 source "$HOME/.dotfiles/.env"
 set +a
fi

# autocompletion for oh my pi
if (( $+commands[omp] )); then
  eval "$(omp completions zsh)"
fi

[[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]] && source "$HOME/powerlevel10k/powerlevel10k.zsh-theme"
