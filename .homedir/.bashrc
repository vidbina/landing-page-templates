# ~/.bashrc: executed by bash(1) for non-login shells.

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors -b`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

EDITOR=vim

exitstatus() {
  if [[ $? == 0 ]]; then
    echo -e "\e[92m"
  else
    echo -e "\e[91m"
  fi
}

export PS1="\[$(exitstatus)\]>\[\e[0m\] "
export PS2="> "

# Load personal Bash config from ./.bashrc-personal. if available
if [[ -f ~/.bashrc-personal ]]; then
  source ~/.bashrc-personal
else
  echo -e "\e[94mNo personal bashrc found at \e[4m~/.bashrc-personal\e[0m"
fi
