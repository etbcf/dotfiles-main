# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

# Function to create a rainbow-colored hostname
get_rainbow_hostname() {
  local text
  text=$(hostname) # Get the actual hostname

  local colors
  colors=(196 202 208 226 118 39 99 201) # Red, Orange, Yellow, Green, Blue, Indigo, Violet

  local rainbow=""
  local index=0

  for ((i = 0; i < ${#text}; i++)); do
    local letter
    letter="${text:i:1}"
    rainbow+=$(tput setaf "${colors[index]}")
    rainbow+="$letter"
    index=$(((index + 1) % ${#colors[@]})) # Cycle through colors
  done

  rainbow+=$(tput sgr0) # Reset formatting
  echo "$rainbow"
}

if [ "$color_prompt" = yes ]; then
  # Define colors
  orange=$(tput setaf 166)
  yellow=$(tput setaf 228)
  green=$(tput setaf 71)
  red=$(tput setaf 196)
  white=$(tput setaf 15)
  blue=$(tput setaf 33)
  bold=$(tput bold)
  reset=$(tput sgr0)

  # Git icon (using Nerd Font Git logo)
  git_icon="" # Nerd Font Git icon

  # Function to get the current git branch and commit SHA (shortened to 7 digits)
  get_git_branch() {
    # Get the current branch
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
      # Get the current commit SHA (7 characters)
      local sha
      sha=$(git rev-parse --short HEAD 2>/dev/null)
      # Check if there are uncommitted changes
      if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        # Show branch, SHA, and red asterisk (*) if there are changes
        if [ -n "$sha" ]; then
          echo "${git_icon} ${blue}${branch}${reset} ${yellow}[${reset}${sha}${yellow}]${reset}${red} (*)"
        else
          echo "${git_icon} ${blue}${branch}${reset}${red} (*)" # No SHA available, but branch has uncommitted changes
        fi
      else
        # Show branch and SHA if clean
        if [ -n "$sha" ]; then
          echo "${git_icon} ${blue}${branch}${reset} ${yellow}[${reset}${sha}${yellow}]${reset}"
        else
          echo "${git_icon} ${blue}${branch}${reset}" # No SHA available
        fi
      fi
    fi
  }

  prompt_command() {
    local status="$?"
    local status_color=""
    if [ $status != 0 ]; then
      status_color=${red} # Set color to red if the last command failed
    else
      status_color=${green} # Set color to green if the last command succeeded
    fi

    # Get the name of the virtual environment if it's activated
    local venv_name=""
    if [ -n "$VIRTUAL_ENV" ]; then
      venv_name="($(basename "$VIRTUAL_ENV")) "
    fi

    # Generate rainbow hostname
    local rainbow_hostname
    if rainbow_hostname=$(get_rainbow_hostname); then
      # Successfully generated rainbow hostname
      PS1+=" $rainbow_hostname"
    else
      # Handle error (optional)
      PS1+=" (hostname error)"
    fi

    # Build the PS1 prompt dynamically with status code color
    PS1="\[${bold}\]\n"

    PS1+="$venv_name"
    PS1+="\[${orange}${bold}\]\u"                         # Username in bold
    PS1+="\[${white}${bold}\] at "                        # "at" in bold
    PS1+="\[${reset}${bold}${rainbow_hostname}${reset}\]" # Hostname in bold
    PS1+="\[${white}${bold}\] in "                        # "in" in bold
    PS1+="\[${green}${bold}\]\W"                          # Current working directory in bold

    # Append Git branch and SHA after the branch name
    local git_branch
    if git_branch=$(get_git_branch); then
      PS1+=" \[\033[38;5;228m\]${git_branch}\[\033[0m\]"
    else
      # Handle failure (optional)
      PS1+=" \[\033[38;5;228m\](no branch)\[\033[0m\]"
    fi

    PS1+="\n"                                # Newline
    PS1+="\[${status_color}\]$ \[${reset}\]" # Status symbol with dynamic color
  }

  export PROMPT_COMMAND='prompt_command' # Set the prompt command to run before each prompt

else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Exports
export PATH="$PATH:$HOME/.local/nvim/bin"
export PATH="$HOME/bin/pesquisa:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/my_neovim/nvim-linux64/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/nvim/lazy-rocks/bin:$PATH"

# Move a file to Trash
function trash() {
  mv "$1" ~/.Trash
}

# Create a directory and change into it
function mkcd() {
  mkdir "$1" && cd "$1" || return
}

# Create a directory, change into it, and initialize a git repository
function mkgit() {
  mkdir "$1" && cd "$1" && git init
}

# Clone a git repository and change into the cloned directory
function mkclone() {
  # Clone the repository
  git clone "$1" || return 1

  # Extract the directory name from the URL
  repo_name=$(basename "$1" .git)

  # Change into the cloned directory
  cd "$repo_name" || return 1
}

_not_inside_tmux() {
  [ -z "$TMUX" ]
}

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

# ensure_tmux_is_running

source "$HOME/bin/pesquisa/pesquisa"

. "$HOME/.cargo/env"

# pip bash completion start
_pip_completion() {
  COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
    COMP_CWORD=$COMP_CWORD \
    PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
}
complete -o default -F _pip_completion pip
# pip bash completion end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
