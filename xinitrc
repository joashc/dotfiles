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
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

ssh-add /hom/boo/.ssh/id_rsa

export LANG=en_AU.UTF-8
export EDITOR=vim
export GOPATH=~/go/gopath
export PATH=/usr/local/bin:/usr/bin
compton -b
xbindkeys

sh -c 'xrandr --newmode "3840x2160R"  533.00  3840 3888 3920 4000  2160 2163 2168 2222 +hsync -vsync'
sh -c 'xrandr --addmode DP1 "3840x2160R"' 
sh -c 'xrandr --addmode DP2 "3840x2160R"' 
sh -c 'xrandr --addmode DP1-1 "3840x2160R"'

sh -c 'xrandr --output DP1 --mode 3840x2160R --rate 59.97 --output eDP1 --mode 3840x2160 --rate 60.00 --left-of DP1'
# sh -c 'xrandr --output eDP1 --off --output DP1 --mode "3840x2160R"

#xmodmap ~/.speedswapper

# make CapsLock behave like Ctrl:
setxkbmap -option caps:escape
xinput --set-prop 11 'libinput Accel Speed' 0.5


xset s off -dpms
exec i3
#exec openbox-session
