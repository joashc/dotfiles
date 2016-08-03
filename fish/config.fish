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
 set -g fish_key_bindings fish_vi_key_bindings
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
function win
  VBoxManage startvm Windows10
end

function cherry
  git cherry-pick $argv
end

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end

function chpwd --on-variable PWD
  status --is-command-substitution; and return
  ls
end
function caf
  cp ~/dotfiles/.nosus ~/dotfiles/suspend.sh
end

function coff
  cp ~/dotfiles/.sus ~/dotfiles/suspend.sh
end

function showvol
  if test (pactl list sinks | grep "Mute: yes" | wc -l)  = "1"
    volnoti-show -m
  else
    pactl list sinks | grep 'Volume:' | egrep -o '[0-9]+%' | tr -d '%' | head -n 1 | bc | xargs -0 volnoti-show
  end
end

function caficon
  if test (cat /home/boo/dotfiles/suspend.sh | wc -l) = "0"
    echo 
  end
end

function batticon
  set perc (acpi | grep -o "[0-9]*%" | tr -d "%" | bc)
  set onbatt (acpi | grep -o "Discharging" | wc -l | bc)
  if test $onbatt -eq 0
    echo 
  else if test $perc -gt 80
    echo 
  else if test $perc -gt 60
    echo 
  else if test $perc -gt 30
    echo 
  else if test $perc -gt 18
    echo 
  else
    echo 
  end
end

function fish_greeting
end

