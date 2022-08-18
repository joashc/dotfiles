!/bin/sh

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

export LANG=en_AU.UTF-8
export EDITOR=vim
export GOPATH=~/go/gopath
export PATH=/usr/local/bin:/usr/bin



#sh -c 'xrandr --addmode "DP-2" "3840x2160R"' 
#sh -c 'xrandr --addmode DP1-1 "3840x2160R"'

sh -c 'xrandr --output HDMI-0 --mode 3840x2160 --rate 59.97'
# sh -c 'xrandr --output eDP1 --off --output DP1 --mode "3840x2160R"

#xmodmap ~/.speedswapper

# make CapsLock behave like Ctrl:
#setxkbmap -option caps:escape
xmodmap /home/boo/.xmodmap
xbindkeys -f /home/boo/.xbindkeysrc
xcape -e 'Mode_switch=Escape'
picom -b
/home/boo/dotfiles/noprimaryclip.sh &


#xinput --set-prop $(xinput | ag Touchpad | awk '{print $6}' | sed 's/id=//g' | bc) 'libinput Accel Speed' 0.6


xset s off -dpms
xsetroot -cursor_name left_ptr
exec i3
#exec openbox-session
