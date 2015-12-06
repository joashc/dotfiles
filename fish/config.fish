# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set -gx LANG en_AU.UTF-8
set -gx LC_ALL en_AU.UTF-8
set -gx LC_CTYPE en_AU.UTF-8
set -gx PATH /usr/local/bin $PATH

set fish_greeting " "

# Theme
set fish_theme agnoster
function lso
    pacman -Qdt
end
function hd
  xrandr --output HDMI3 --mode 1920x1080
end
function uhd
  xrandr --output HDMI3 --mode 3840x2160
end
function rmo
    sudo pacman -Rs (pacman -Qtdq)
end
function ipext
    curl http://ipecho.net/plain ; echo
end
function lt
    ls -ltr $argv
end
function f
    find . -iname $argv
end
function em
    emacsclient -t $argv
end
function sdn
    sudo shutdown now
end
function eme
    emacsclient -c $argv &
end
function windows
    VBoxManage startvm Windows
end
function co
    git checkout $argv
end
function s
    git status -s $argv
end
function l
    git lg $argv
end

function activate
    sudo modprobe vboxdrv
end

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins autojump vi-mode

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

sh ./xcape &

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        #exec startx
    end
end

