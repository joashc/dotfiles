# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish
set -x LANG en_AU.UTF-8
set -x LC_ALL en_AU.UTF-8
set -x LC_CTYPE en_AU.UTF-8

set fish_greeting " "

# Theme
set fish_theme agnoster
function lso
    pacman -Qdt
end
function rmo
    sudo pacman -Rs (pacman -Qtdq)
end
function ipext
    curl http://ipecho.net/plain ; echo
end
function lt
    ls -ltr
end
function f
    find . -iname $argv
end
function windows
    VBoxManage startvm Windows
end
function co
    git checkout
end
function s
    git status -s
end
function l
    git lg
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

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

sh ./xcape &
