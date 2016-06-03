# vim:ft=zsh ts=2 sw=2 sts=2

RETVAL=$?

function mark() {
  echo -n '%F{cyan}\u2192'
}

function git_stash() {
  # git stash
  stashNb=`git stash list 2> /dev/null | wc -l`
  if [ "$stashNb" != "0" ]
  then
    echo -n " %F{blue}"
    for i in $(seq 1 $stashNb); do
      echo -n "·"
    done
    echo -n '%f'
  fi

  echo ''
}

PROMPT='%B%F{red}%n  %F{green}%~ $(git_prompt_info)$(git_stash)  $(mark)%f%b '
RPROMPT='%b%F{blue}⌚ %*%f %B%F{red}%M'

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX="%b%fon %F{magenta}\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}\u00b1"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{green}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export LS_COLORS=$LS_COLORS:'ln=1;92:di=1;31' 
