#!/bin/bash 
#^^^^^^^^^^ just for the hilighting

# . $HOME/config/bashrc --> ~/.bashrc

# Aaaaak, not running interactively, bail
[ -z "$PS1" ] && return

# Is there any other mode?
set -o vi

case "$OS" in
  *indows* )

    # god i hate this path
    export PF="/c/Program Files"
    export XPF="/c/Program Files (x86)"
    alias pf="cd \"$PF\""
    alias xpf="cd \"$XPF\""
    export TERM=msys
    export PATH="$XPF/Vim/Vim74:/c/Python27:$PF/Java/jdk1.7.0_51/bin:$PATH"
    ;;
esac

# home always comes first (in life and bash)
export PATH=\
$HOME/bin:\
$HOME/powergit/bin:\
$HOME/mdaddlinks:\
$HOME/filters:\
$HOME/fmt:\
$HOME/note:\
$HOME/clone:\
$PATH

#ulimit -S -c 0      # Core dumps off
set -o notify
set -o noclobber
set -o ignoreeof

alias more=less
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias tstamp='date +%Y%m%d%H%M%S'

alias ls='ls -h --color'   #  Mmmmmm, pretttty
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.
alias ll='ls -lv'
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.

llastf () {
  # recursively lists all files in reverse chronological order of
  # when they were last modified
  top=$1
  [ "$1" = "" ] && top=.
  find $top -type f -printf '%TY-%Tm-%Td %TT %p\n' |sort -r
}

llastd () {
  # same but directories
  top=$1
  [ "$1" = "" ] && top=.
  find $top -type d -printf '%TY-%Tm-%Td %TT %p\n' |sort -r
}

lall () {
  find . -name "*$1*"
}

grepall () {
  find . -exec grep "$1" {} /dev/null \;
}

join () {
  perl -e '$d=shift; print(join($d,@ARGV))' "$@"
}

###########################################################
# PowerGit stuff
###########################################################

export GITURLS=~/config/giturls

gcd () {
  cd `gls $1 | perl -e '@m=split(/\s+/,<STDIN>);print$m[1]'`
}

###########################################################
# Editor and blogging stuff
###########################################################

if [ "`which vim 2>/dev/null`" ]; then
  export EDITOR=vim
  alias vi=vim
fi

postname () {
  echo `date +%Y-%m-%d`-`join - "$@"`.markdown
}

blog_header="---
layout: post
---

"

write () {
  path="$1"
  file=`postname $path"$@"`
  vim + +start $post
}

writepost () {
  site="$1"
  post=`postname $site/"$@"`
  [ ! -e "$post" ] && echo "$blog_header" > $post
  vim + +start $post
}

export SITE="$HOME/com"
export SITEME="$HOME/me"

alias blog='writepost $SITE/_posts'
alias blogs='vi $SITE/_posts'
alias blogme='writepost $SITEME/_posts'
alias blogsme='vi $SITEME/_posts'
alias draft='writepost $SITE/_drafts'
alias drafts='vi $SITE/_drafts'
alias draftme='writepost $SITEME/_drafts'
alias draftsme='vi $SITEME/_drafts'
alias com='cd ~/com'
alias me='cd ~/me'
alias show='jekyl serve'

alias notes='note'
alias todos='todo'

alias bin='cd ~/bin'
alias private='cd ~/private'
alias trainemon='cd ~/trainemon'

