set -gx LANG en_AU.UTF-8
set -gx LC_ALL en_AU.UTF-8
set -gx LC_CTYPE en_AU.UTF-8
set -g Z_SCRIPT_PATH /usr/lib/z.sh


# Path to Oh My Fish install.
set -gx OMF_PATH "/home/boo/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/boo/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set fish_plugins z

function fish_user_key_bindings
  fish_vi_key_bindings
end


function hd
  xrandr --output HDMI3 --mode 1920x1080
end
function uhd
  xrandr --output HDMI3 --mode 3840x2160
end

function rmo
  sudo pacman -Rns (pacman -Qdtq)
end
function lso
  pacman -Qdtq
end

function lt
  ls -ltrh
end

function f
  find . -iname $argv
end

function em
  emacsclient -t $argv
end
function eme
  emacsclient -c $argv &
end

function s
  git status -s $argv
end
function co
  git checkout $argv
end
function rb
  git rebase $argv
end
function l
  git lg $argv
end
function mg
  git merge $argv
end
function m
  git commit -m $argv
end
function am
  git commit -am $argv
end
function A
  git add -A $argv
end
function rs
  git reset $argv
end
function RSH
  git reset --hard $argv
end
function com
  git commit $argv
end
function con
  git rebase --continue $argv
end
function amend
  git commit --amend $argv
end
function p
  git push $argv
end
function pl
  git pull $argv
end
function a
  git add $argv
end
function cfon
  touch ~/.caf
end
function cfoff
  rm ~/.caf
end
function win
  VBoxManage startvm Windows10
end

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end
