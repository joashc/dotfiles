set -gx LANG en_AU.UTF-8
set -gx LC_ALL en_AU.UTF-8
set -gx LC_CTYPE en_AU.UTF-8
set -g Z_SCRIPT_PATH /usr/lib/z.sh
set -gx PATH /home/boo/.local/bin $PATH
set -gx PATH /home/boo/.local/bin $PATH
set -gx PATH /usr/bin/core_perl/ $PATH
set -gx PATH /home/boo/.config/yarn/global/node_modules/.bin $PATH
set -gx PATH /home/boo/go/gopath/bin $PATH
set -gx PATH /opt/google-cloud-sdk/bin $PATH

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

abbr s 'git status -s'
abbr co 'git checkout'
abbr rb 'git rebase'
abbr l 'git lg'
abbr mg 'git merge'
abbr m 'git commit -m'
abbr am 'git commit -am'
abbr A 'git add -A'
function rs
  git reset $argv
end
function RSH
  git reset --hard $argv
end
function com
  git commit $argv
end
abbr con 'git rebase --continue'
abbr amend 'git commit --amend'
abbr p 'git push'
abbr pl 'git pull'
function a
  git add $argv
end

function cherry
  git cherry-pick $argv
end

function kl
  kubectl logs (kubectl get pods | grep $argv | awk '{print $1}')
end

function klf
  kubectl logs (kubectl get pods | grep $argv | awk '{print $1}') --tail=10 -f
end

abbr pw 'pass show -c'
abbr po 'pass otp show -c'

if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR -eq 1
        exec startx -- -keeptty
    end
end

function chpwd --on-variable PWD
  status --is-command-substitution; and return
  ls
end
function wake
  echo "Not sleepy"
  cp ~/dotfiles/.nosus ~/dotfiles/suspend.sh
end

function slpy
  echo "Sleepy"
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

function dl
  git diff HEAD^ HEAD
end

function wf
  sudo wifi-menu
end

function dns
  if echo "nameserver 8.8.8.8" | cat - /etc/resolv.conf > /home/boo/.resolv
    echo "Updated DNS..."
  end
end

function vpn
  if ps cax | grep openvpn
    echo "OpenVPN already running, killing..."
    sudo killall -q openvpn
  end
  if echo "nameserver 8.8.8.8" | cat - /etc/resolv.conf > /home/boo/.resolv
    echo "Updating DNS..."
    if sudo mv /home/boo/.resolv /etc/resolv.conf
      echo "Updated DNS"
      sudo openvpn --config ~/joashnew.ovpn
    end
  else 
    echo "Updating DNS failed"
  end
end

function fish_greeting
end


function dev
  kubectl config use-context kube-dev.getswift.co
end

function prod
  kubectl config use-context kube.getswift.co
end

function eug
  kubectl config use-context kube-euwest.k8s.local
end

function eu
  kubectl config use-context eu
end

function azure
  kubectl config use-context azure
end

function kafprod
  kubectl config use-context kafka
end

function kp
  kubectl config current-context
  kubectl proxy
end

function mon
  sh -c 'xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 0x384 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP1-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1-2 --off --output DP1-3 --mode 1920x1080 --pos 3840x0 --rotate normal --output DP2 --off'
end

function spig
  kubectl port-forward (kubectl get pods --namespace spinnaker | grep spin-gate | awk '{print $1}') 8084 --namespace spinnaker
end

function spid
  kubectl port-forward (kubectl get pods --namespace spinnaker | grep spin-deck | awk '{print $1}') 9000 --namespace spinnaker 
end

function uhd
  xrandr --output eDP1 --mode 3200x1800
end

function 4k
  xrandr --output eDP1 --mode 3840x2160
end

function hd
  xrandr --output eDP1 --mode 1920x1080
end

function ama
  pass show -c amazon.com/awsprod
end

function otp
  pass otp show -c awsprod
end

function mfa
  aws sts get-session-token --serial-number (cat ~/.mfaarn) --token-code (pass otp show awsprod) > ~/.awsmfa
  sed -e "s`MFA_ACCESS_KEY`"(cat ~/.awsmfa | jq ".Credentials.AccessKeyId" -r)"`" ~/.aws/credentials.template > ~/.awstemp
  sed -i -e "s`MFA_SECRET_ACCESS_KEY`"(cat ~/.awsmfa | jq ".Credentials.SecretAccessKey" -r)"`" ~/.awstemp
  sed -e "s`MFA_SESSION_TOKEN`"(cat ~/.awsmfa | jq ".Credentials.SessionToken" -r)"`" ~/.awstemp > ~/.aws/credentials
end

function trashempty
  echo -n "Removing the trash........" | pv -qL 10 ; rm -rf  ~/.local/share/Trash/files
end

function lr
  ls -lrt
end

function tv
  xrandr --output DP1 --mode 3840x2160R --output eDP1 --off
end

function tv30
  xrandr --output DP1 --mode 3840x2160 --output eDP1 --off
end

function win
  sudo virt-viewer --uuid cdd8c5d2-0939-4435-9863-8ed9310fcb8c -f
end

function pd
  git diff HEAD~1 HEAD
end

function vf
  vim (fzf)
end

function gd
  git diff
end

function xc
  xclip -selection clipboard
end

function kubetoken 
    kubectl -n kube-system get secret --output=jsonpath='{.data.token}' (kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | base64 --decode | xclip -se c
end
