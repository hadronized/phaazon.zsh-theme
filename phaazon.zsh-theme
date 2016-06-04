# vim:ft=zsh ts=2 sw=2 sts=2

RETVAL=$?

function mark() {
  echo -n '%B%F{cyan}\u2192'
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
    echo -n '%f '
  fi
}

function git_last_tag() {
  tag=`git describe HEAD --tags --abbrev=0 2> /dev/null`
  if [ "$tag" != "" ]
  then
    echo -n " %F{yellow}$tag"
  fi
}

function cargo_last_tag() {
  tag=`grep version Cargo.toml | cut -f3 -d' ' | tr -d '"'`
  if [ "$tag" != "" ]
  then
    echo -n " %F{blue}v$tag"
  fi
}

function tags() {
  git status &> /dev/null

  if [ $? -eq 0 ]
  then
    git_tag=`git describe HEAD --tags --abbrev=0 2> /dev/null` || return
    cargo_tag=`grep version Cargo.toml 2> /dev/null | cut -f3 -d' ' | tr -d '"'`

    if [[ "$git_tag" = "v$cargo_tag" || $? -ne 0 ]]
    then
      echo -n " %F{blue}($git_tag)"
    else
      echo -n " %F{blue}(%F{red}$git_tag %F{green}$cargo_tag%F{blue})"
    fi
  fi
}

PROMPT='%B%F{green}%n  %F{red}%~ $(git_prompt_info)$(git_stash)$(tags) $(mark)%f%b '
RPROMPT='%B%F{blue}%*%f %F{black}%M'


# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX="%B%F{magenta}\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}\u00b1"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{green}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export LS_COLORS=$LS_COLORS:'ln=1;92:di=1;31' 
