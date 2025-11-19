# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
unsetopt beep notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/baselash/.zshrc'
# export FUNCNEST=500

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Hooking zoxide to the shell
eval "$(zoxide init zsh)"



# if [[ "$TERM" =~ xterm.*|kitty|alacritty ]]; then
#   echo -ne '\e[2 q'
# fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
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




# Clear Cache
alias clear-cache="yay -Scc"


# For backing-up Very Important files and directories
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


# Easier life aliases
# alias venv-activate="source venv/bin/activate"
# alias venv-create="python3 -m venv venv"
alias home="cd ~" 
alias n="nvim"
alias myprojects="cd /mnt/d/myproject/"
alias section="cd /mnt/d/myproject/section/"
alias format-folder="/usr/bin/clang-format --style GNU --dump-config > .clang-format"
alias zconfig="nvim /home/baselash/.zshrc"
alias zsource="exec zsh"
# alias minecraft="java -jar /home/baselash/Downloads/TLauncher.v10/TLauncher.jar"
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
# alias darkmaster="cd /home/baselash/Work/DarkMasterEcom/"


# Show-off
alias c="cmatrix"
alias h="hollywood"


# alias ears="bluetoothctl connect 98:34:8C:03:AA:D7"
# alias cut-ears="bluetoothctl disconnect 98:34:8C:03:AA:D7"

# >>> for termux (phone ssh connection)
alias ssh-fedora="XDG_SESSION_TYPE=tty ssh baselash@100.124.106.8"



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
    echo "Activated the virutal environment called (venv)"
    return 0
  fi

  local name="$1"
  source "$name"/bin/activate
}

function runserver ()
{
  if [ "$#" -ne 1 ]; then
    python manage.py runserver
    return 0
  fi
  python manage.py runserver $1
}

function zen()
{
  venv-activate /home/baselash/Work/zen/venv
  cd /home/baselash/Work/zen
}

function ccpp ()
{
  if [ "$#" -ne 1 ]; then
    echo "Please Enter the app name: create-cpp <name>"
    return 0
  fi
  cp ~/.config/commands/app.cpp .
  mv ./app.cpp ./"$1".cpp
}


# OH-MY-POSH config
export PATH="$HOME/.local/bin:$PATH"
# eval "$(oh-my-posh init zsh)"
eval "$(oh-my-posh init zsh --config /home/baselash/.config/oh-my-posh/.mytheme.omp.json)"
# /var/lib/flatpak/exports/bin
