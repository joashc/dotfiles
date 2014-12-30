#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
xset +fp /usr/share/fonts/OTF

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi
xmodmap ~/.speedswapper
xcape
export LANG=en_AU.UTF-8
<<<<<<< HEAD
export EDITOR=vim
export GOPATH=~/go/gopath
exec i3
=======
exec herbstluftwm --locked
exec xcompmgr -c
>>>>>>> b47eccce24eb85bc8b72f6f2f1672102bb944e4a
