# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias l='ls -l'

alias rake="bundle exec rake"
alias rails="bundle exec rails"
alias gitst="git status"

PATH="/usr/local/bin:$PATH" 

# bash completion
if [ ! -f /etc/bash_completion ]; then
  if [ -f ~/.ssh/known_hosts ]; then 
    _yamatomo_known_hosts() {
      local hosts cur prev
     
      hosts=$(cat ~/.ssh/known_hosts | awk '{print $1}')
      cur="${COMP_WORDS[COMP_CWORD]}"
      prev="${COMP_WORDS[COMP_CWORD-1]}"
    
      if [ $COMP_CWORD = 1 ]; then
        COMPREPLY=( $( compgen -W "$hosts"    -- $cur ))
      fi
    }
    complete -F _yamatomo_known_hosts ssh scp
  fi
fi

  
