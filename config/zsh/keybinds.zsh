# Zsh keybindings
bindkey '^[f' autosuggest-accept
bindkey '^[j' history-search-forward
bindkey '^[k' history-search-backward
bindkey '^[l' forward-word
bindkey '^[h' backward-word

# Movement
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .6="cd ../../../../../.."

# Listing
alias l="eza --color=always --git --icons=always --group-directories-last --no-filesize --no-time --no-user --no-permissions --long"
alias ls="eza --color=always --git --icons=always --group-directories-last --no-filesize --no-time --no-user --no-permissions "
alias la="eza --color=always --git --icons=always --group-directories-last --no-filesize --no-time --no-user --no-permissions --long --all  "
alias ll="eza --color=always --git --icons=always --group-directories-last --long --all"
alias lt="eza --color=always --git --icons=always --group-directories-last -T -L 3 "
alias l.="eza --color=always --git --icons=always --group-directories-last -d .*"

# Nvim
alias v="nvim"
alias vim="nvim"

# Git
alias g="git"
alias gi="git init"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gd="git diff"
alias gl="git log --oneline --graph --decorate"
alias gll="git log --graph --decorate"
alias gb="git branch"
alias gbd="git branch -d"
alias gbs="git checkout -b"
alias gsw="git switch"
alias gm="git merge"
alias gcl"git clone"

# Others
alias c="codium ."
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"
alias lg="lazygit"
alias bat="bat --theme base16"
alias cat="bat -p --theme base16"
alias mkdir="mkdir -p"
alias rm="trash"
alias rmdir="trash"
alias music="termusic ~/Music"
alias mv="mv -i"
alias cp="cp -ri"
alias z="zathura"
alias q="exit"

# Yazi shell wrapper to 'cd' in a directory when quitting yazi with 'q'
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
