export PATH="$HOME/.local/scripts:$PATH"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=0
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ls="eza -a --icons --git --group-directories-first"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"

source /opt/homebrew/opt/fzf/shell/completion.zsh

source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias cd='z'

# keybind for tmux-sessionizer script
bindkey -s '^[t' "tmux-sessionizer\n"

alias gbr='gradle build & gradle run'

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

. "$HOME/.local/bin/env"

# Added by Antigravity CLI installer
export PATH="/Users/hvu/.local/bin:$PATH"

# bun completions
[ -s "/Users/hvu/.bun/_bun" ] && source "/Users/hvu/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ -r "$HOME/.dotfiles/.env" ]]; then
 set -a
 source "$HOME/.dotfiles/.env"
 set +a
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
