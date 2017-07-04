#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources
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
export LANG=en_AU.UTF-8
export EDITOR=vim
export GOPATH=~/go/gopath
export PATH=/usr/local/bin:/usr/bin
compton -b
xbindkeys

sh -c 'xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 0x384 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP1-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1-2 --off --output DP1-3 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP2 --off'

feh ~/wall.jpg --bg-fill
#xmodmap ~/.speedswapper

# make CapsLock behave like Ctrl:
setxkbmap -option caps:escape

# urxvt daemon
urxvtd -q -f -o

xset s off -dpms
xcape
libinput-gestures-setup start
exec i3
#exec openbox-session
