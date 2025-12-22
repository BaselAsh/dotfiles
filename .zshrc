# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=10000
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/baselash/.zshrc'
# export FUNCNEST=500

# Auto-start Hyprland on TTY1
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
	exec Hyprland
fi

autoload -Uz compinit
compinit
# End of lines added by compinstall


# Path for npm and html/css language servers
export PATH="$PATH:/usr/bin"

# To make sure the nvim configuration doesn't conflict with anything else
export PATH="$HOME/.npm-global/bin:$PATH"



# Setting neovim as the default text editor
export EDITOR="kitty nvim"
export VISUAL="kitty nvim"

# Hooking zoxide to the shell
eval "$(zoxide init zsh)"

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

PROMPT="%~ >> "

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
alias nvim-config="cd /home/baselash/.config/nvim/"
# alias pip="pipx"
# alias factorio="/home/baselash/projects/trying/Factorio_Linux/factorio/bin/x64/factorio"
# alias cut-hands="xinput disable 14"
# alias hands="xinput enable 14"
alias relax="dolphin /mnt/f/Relax/"
alias brave="/var/lib/flatpak/exports/bin/com.brave.Browser"
alias hypr-config="n ~/.config/hypr/hyprland.conf"
alias 1disk="cd /mnt/Data_1/"
alias 2disk="cd /mnt/Data_2/"
alias y="yazi"
alias open="xdg-open"
# alias darkmaster="cd /home/baselash/Work/DarkMasterEcom/"


# Integrating UV with python
alias python="uv run python"


# Show-off
alias c="cmatrix"
alias h="hollywood"


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
    source venv/bin/activate
    echo "Activated the virutal environment called (venv)"
    return 0
  fi

  local name="$1"
  source "$name"/bin/activate
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


# OH-MY-POSH config
export PATH="$HOME/.local/bin:$PATH"

# Export ttyper 
export PATH="$HOME/.cargo/bin:$PATH"
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config /home/baselash/.config/oh-my-posh/.mytheme.omp.json)"
# /var/lib/flatpak/exports/bin
