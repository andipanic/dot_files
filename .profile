# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# startx automatically
if [ -z "$DISPLAY" ] && [ $(tty) = /dev/tty2 ]; then
    startx
fi


# If synclient exists, set our touchpad up correctly.
if ( hash synclient 2>/dev/null )
then
    synclient TapButton1=1 2>/dev/null
    synclient TapButton2=3 2>/dev/null
    synclient TapButton3=2 2>/dev/null
    synclient VertTwoFingerScroll=1 2>/dev/null
    synclient HorizTwoFingerScroll=1 2>/dev/null 
fi


