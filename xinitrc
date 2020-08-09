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
compton -b --config /home/boo/.compton.conf

xbindkeys

sh -c 'xrandr --newmode "3840x2160R"  712.75  3840 4160 4576 5312  2160 2163 2168 2237 -hsync +vsync'

sh -c 'xrandr --addmode DP1 "3840x2160R"' 
#sh -c 'xrandr --addmode "DP-2" "3840x2160R"' 
#sh -c 'xrandr --addmode DP1-1 "3840x2160R"'

#sh -c 'xrandr --output DP2 --mode 3840x2160R --rate 59.97 --output eDP1 --mode 3840x2160 --rate 60.00 --left-of DP2'
# sh -c 'xrandr --output eDP1 --off --output DP1 --mode "3840x2160R"

#xmodmap ~/.speedswapper

# make CapsLock behave like Ctrl:
#setxkbmap -option caps:escape
xmodmap /home/boo/.xmodmap
xcape -e 'Mode_switch=Escape'

xinput --set-prop $(xinput | ag Touchpad | awk '{print $6}' | sed 's/id=//g' | bc) 'libinput Accel Speed' 0.6


xset s off -dpms

exec i3
#exec openbox-session
