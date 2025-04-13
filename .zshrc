# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Define config path
ZSH_CONFIG_DIR="$HOME/.config/zsh"

# Source zsh config
for file in "$ZSH_CONFIG_DIR"/*.zsh; do
	[[ -f "$file" ]] && source "$file"
done

# Dowload zinit, it it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completion
autoload -Uz compinit
if [ -f ~/.zcompdump ]; then
	compinit -C
else
	compinit
fi

# Zsh basic options
setopt autocd  # Change directory just by typing its name
setopt correct # Auto correct mistakes

# History
HISTSIZE=5000			 	 # Max number of history entries
HISTFILE=~/.zsh_history		 # Location of the history file
SAVEHIST=$HISTSIZE			 # Number of commands to save
HISTDUP=erase				 # Avoid duplicate entries
setopt appendhistory		 # Append history instrad of overwriting
setopt sharehistory			 # Share history across terminals
setopt hist_ignore_space	 # Ignore commands starting with a space
setopt hist_ignore_all_dups  # Ignore duplicate entries across sessions
setopt hist_save_no_dups	 # Avoid saving duplicates in history
setopt hist_ignore_dups		 # Ignore duplicate commands
setopt hist_find_no_dups	 # Prevent duplicates in history searches

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Oh my posh
export POSH_CACHE="$HOME/.cache/oh-my-posh"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Start tmux when opening terminal
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# Print a pokemon when opening the terminal
# krabby random --no-title
export PATH="$INSTALL_DIR:$PATH"
