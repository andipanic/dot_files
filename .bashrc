# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias xbox='sudo xboxdrv --detach-kernel-driver'
alias rtorrent='rtorrent $(cat ~/.magnets)'
alias GM='git checkout master'
alias GB='git checkout -b'
alias GC='git checkout'

alias minecraft='java -jar ~/bin/Minecraft.jar'

# apt alias
alias I="sudo apt install"
alias R="sudo apt remove"
alias AR="sudo apt-get autoremove"
alias AU="sudo apt update"
alias AG="sudo apt upgrade"
alias S="aptitude search"

# other alias
alias irssi='irssi -c irc.freenode.net'
alias D='ls /dev/sd*'
alias P='sudo pip install'
alias V='virtualenv'
alias speedtest='wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias mkgit=mkgitfunction
alias M=mountfunction
alias UM=unmountfunction
alias PS=pythonServer
alias gitpush=gitpush
alias gitclone=gitclonefunction
alias s='ssh'
alias activate='. venv/bin/activate'
alias playdir='mocp -c -a $1 -p'
alias feh='feh -ZF'

mountfunction() {
    sudo mkdir /mnt/$2
    sudo mount /dev/sd$1 /mnt/$2
    cd /mnt/$2
    ls
}

unmountfunction() {
    sudo umount /mnt/$1
    sudo rmdir /mnt/$1
}

mkgitfunction() {
    ssh -t git "mkdir /opt/git/$1\.git && cd /opt/git/$1\.git && git init --bare"
    git init
    git add .
    git commit -m "initial commit"
    git remote add origin git:/opt/git/$1\.git
    git push origin master
}
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

export PATH=$PATH:/home/andy/bin
export EDITOR=/usr/local/bin/vim
#export WORKON_HOME=/home/andy/.virtualenvs
#export PROJECT_HOME=/home/andy/projects
#export PYTHONPATH=/home/andy/projects/robotnik
#export ROBOTNIK_SETTINGS=conf.dev_settings
#export ANDROID_HOME=/home/andy/Android/Sdk/
#. /usr/local/bin/virtualenvwrapper.sh


# Cool functions

#pythonServer server port directory(optional)
pythonServer() {
    if [ -z $3 ]; then
        $3 = '~/'
    fi
    ssh $1 -L$2:localhost:$2 "cd $3 && python -m SimpleHTTPServer $2"
}

#gitpush comment(optional)
gitpush() {
    if [ -z $1 ]; then
        COMMIT="I was too lazy to write a commit statement"
    else
        COMMIT="$1"
    fi
    git add .
    git commit -m "$COMMIT"
    git push origin master
}

#gitclone package directory/to/put/it/in/
gitclonefunction() {
    if [ -z $2 ]; then
        DIR="$(pwd)"
    else
        DIR="$(echo $2 | sed 's/\/$//')" # strips trailing / character
    fi
    git clone git:/opt/git/$1\.git "$DIR/$1"
}

alias magnet="cat ~/.mag_links | while read line; do magnet_puller.py \"$line\" >> .magnets; done"

playlist_pull() {

  echo "Paste in a user's playlist page to pull all videos"
  echo "Put in a search term as the first argument to specify a pattern"

  cat |
  egrep -o '\/playlist\?list=..................................' | 
  grep "$1" |
  while read line; do
    youtube-dl -f 22 "https://www.youtube.com$line"
  done

  echo "\nAll finished Downloading! "
  echo "\n\nEnjoy! (_=o,~,'_)\n"

}

watch_pull() {
  echo "Paste in the source to any list of youtube videos"
  
  cat |
  egrep -o '\/watch\?v=...........' | sort | uniq |
  while read line; do
    youtube-dl -f 22 "https://www.youtube.com$line"
  done

  echo "\nAll finished, enjoy! "
}

export PATH=$HOME/local/bin:$PATH

export NVM_DIR="/home/andy/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
