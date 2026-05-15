# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY          # Share history between different Kitty windows
setopt HIST_IGNORE_ALL_DUPS   # Don't record the same command twice
setopt HIST_IGNORE_SPACE      # Commands starting with a space won't be saved (good for passwords)
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks

# Function to sync Zsh vi-mode yank with wl-copy
function vi-yank-to-clipboard() {
    zle vi-yank
    echo "$CUTBUFFER" | wl-copy
}
zle -N vi-yank-to-clipboard
bindkey -M vicmd 'y' vi-yank-to-clipboard

# Clipboard
alias c='wl-copy'
alias v='wl-paste'


unsetopt beep notify
bindkey -v
# Search History
bindkey "^R" history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/baselash/.zshrc'
# export FUNCNEST=500

# Auto-start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec start-hyprland
fi

autoload -Uz compinit
for dump in ~/.zcompdump(N.m1); do
    compinit
done
compinit -C
# End of lines added by compinstall


# Path for npm and html/css language servers
export PATH="$PATH:/usr/bin"

# To make sure the nvim configuration doesn't conflict with anything else
export PATH="$HOME/.npm-global/bin:$PATH"



# Setting neovim as the default text editor
export EDITOR="kitty nvim"
export VISUAL="kitty nvim"

# Hooking zoxide to the shell
eval "$(zoxide init zsh --cmd cd)"

# Hooking FZF to the shell
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p90%,70%"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


# Recommended default replacement for ls
alias ls='eza --color=always --group-directories-first --icons'

# Long list, human-readable, with Git status and directories first
alias ll='eza -la --git --header --time-style=long-iso --icons'

# Long list, showing only directories as a tree, up to depth 2
alias ld='eza -lD --level=2 --tree' 

# Lists only files, sorted by size (great for cleaning up)
alias lS='eza --only-files --sort=size --long --reverse --icons'


# if [[ "$TERM" =~ xterm.*|kitty|alacritty ]]; then
#   echo -ne '\e[2 q'
# fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

PROMPT='%F{6}╭─%f %F{5}%~%f
%F{6}╰─%f %F{4}➜%f '

# Greeting
#figlet "Welcome, Basel !"
# cat ~/.welcome



# Typo aliases
# alias clea="clear"
# alias cear="clear"
# alias cler="clear"
# alias cearr="clear"
# alias cleear="clear"
# alias cllear="clear"
# alias ccllear="clear"
# alias claer="clear"
# alias caer="clear"
# alias rclear="clear"
# alias ccclear="clear"
# alias cclear="clear"
# alias cleaar="clear"
# alias clearr="clear"
# alias clera="clear"
# alias lls="ls"
# alias cdd="cd"
# alias ccd="cd"
# alias easr="ears"
# alias touhc="touch"






# For backing-up Very Important files and directories
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


# Easier life aliases
# alias venv-activate="source venv/bin/activate"
# alias venv-create="python3 -m venv venv"
alias home="cd ~" 
alias n="nvim"
alias myprojects="cd /mnt/d/myproject/"
alias section="cd /mnt/d/myproject/section/"
alias format-folder="/usr/bin/clang-format -style=LLVM --dump-config > .clang-format"
alias zconfig="nvim /home/baselash/.zshrc"
alias zsource="exec zsh"
alias minecraft="sh /home/baselash/Applications/SKLauncher/launch.sh"
# alias stardew="/home/baselash/'GOG Games'/'Stardew Valley'/start.sh"
# alias pip="pipx"
# alias factorio="/home/baselash/projects/trying/Factorio_Linux/factorio/bin/x64/factorio"
# alias cut-hands="xinput disable 14"
# alias hands="xinput enable 14"
alias relax="dolphin /mnt/f/Relax/"
alias brave="/var/lib/flatpak/exports/bin/com.brave.Browser"
alias nvim-config="nvim /home/baselash/.config/nvim/"
alias hypr-config="n ~/.config/hypr/"
alias waybar-config="n ~/.config/waybar/"
alias kitty-config="n ~/.config/kitty/"
alias tmux-config="n ~/.config/tmux/"
alias 1disk="cd /mnt/Data_1/"
alias 2disk="cd /mnt/Data_2/"
alias y="yazi"
alias open="xdg-open"
# alias darkmaster="cd /home/baselash/Work/DarkMasterEcom/"

# YT in MPV
alias ytv='mpv --ytdl-format="bestvideo[height<=1080]+bestaudio/best" '

## Automatically attach to 'default' session or create it
alias tmx="tmux attach-session -t default || tmux new-session -s default"




# Show-off
alias h="hollywood"


# Example usage:
# cat file.txt | c    <- Copies file content
# v > new_file.txt    <- Pastes into a file

# alias ears="bluetoothctl connect 98:34:8C:03:AA:D7"
# alias cut-ears="bluetoothctl disconnect 98:34:8C:03:AA:D7"

# >>> for termux (phone ssh connection)
alias ssh-fedora="XDG_SESSION_TYPE=tty ssh baselash@100.124.106.8"

# STOP FIXING MY TYPOS
# This will override any existing command-not-found handler and make it do nothing.
# command_not_found_handler() {
#     return 127
# }

# Connect to the earbuds 
function ears ()
{
    bluetoothctl power on
    bluetoothctl connect 98:34:8C:03:AA:D7
}

# Disconnect to the earbuds 
function cut-ears ()
{
    bluetoothctl disconnect 98:34:8C:03:AA:D7
}

# Make a virtual environment
function venv-create ()
{
  if [ "$#" -ne 1 ]; then
    python3 -m venv venv
    echo "Created a virtual environment called (venv)"
    return 0
  fi

  local name="$1"
  python3 -m venv $name
 }


# Activate a virtual environment
function venv-activate ()
{
  if [ "$#" -ne 1 ]; then
# source venv/bin/activate  # commented out by conda initialize
    echo "Activated the virtual environment called (venv)"
    return 0
  fi

  local name="$1"
# source "$name"/bin/activate  # commented out by conda initialize
}

function runserver ()
{
  if [ "$#" -ne 1 ]; then
    uv run manage.py runserver
    return 0
  fi
  uv run manage.py runserver $1
}

function zen()
{
  cd /home/baselash/Work/zen
}

function ccpp ()
{
  if [ "$#" -ne 1 ]; then
    echo "Please Enter the app name: ccpp <name>"
    return 0
  fi
  cat ~/.config/commands/app.cpp > ./"$1".cpp

  # mv ./app.cpp ./"$1".cpp
}

# Focus Timer
focus() {
    local duration=${1:-90} # Default to 90 minutes
    echo "Focus mode engaged for $duration minutes. Good luck, Basel."
    sleep $((duration * 60)) && notify-send "Focus Session Complete" "Time to step away from the keyboard." && echo -e "\a"
}

# Time-stamped Journal Function
jj() {
    local journal_dir="$HOME/Workspace/Journal/daily/"
    # Format: YYYY-MM-DD_HHh.md (e.g., 2026-02-21_14h.md)
    local filename="$(date +%Y-%m-%d).md"
    
    mkdir -p "$journal_dir"
    
    if [ ! -f "$journal_dir/$filename" ]; then
        echo "# Log: $(date +'%Y-%m-%d at %I:%M %p')" > "$journal_dir/$filename"
        echo -e "\n## Status Update\n- " >> "$journal_dir/$filename"
    fi
    
    # Open in nvim, jump to end, and enter insert mode
    nvim "+normal G" "+startinsert" "$journal_dir/$filename"
}

# Monthly Review: Usage 'mr 2026-02'
mr() {
    local search_month="$1"
    local journal_dir="$HOME/Workspace/Journal/daily/"
    
    echo "--- Monthly Review for $search_month ---"
    # Concatenate all files matching the month and clean up headers
    cat "$journal_dir/$search_month"*.md | grep -v "^# " | grep -v "^---" | sed '/^$/d'
}

nman() {
    nvim -c "Man $1" -c "only"
}

launch() {
    systemd-run --user --machine=$USER@.host --collect "$@"
}

# OH-MY-POSH config
# export PATH="$HOME/.local/bin:$PATH"

# Export ttyper 
export PATH="$HOME/.cargo/bin:$PATH"
# eval "$(oh-my-posh init zsh)"
# eval "$(oh-my-posh init zsh --config /home/baselash/.config/oh-my-posh/.mytheme.omp.json)"
# source ~/.oh-my-posh.zsh
# /var/lib/flatpak/exports/bin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
conda-init() {
    __conda_setup="$('/home/baselash/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/baselash/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/baselash/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/baselash/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}
# <<< conda initialize <<<

export UV_LINK_MODE=copy

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Editing command in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# ls after cd automatically
chpwd() {
    ls
}

