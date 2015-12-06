# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

source ~/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle vi-mode
antigen bundle fancy-ctrl-z
antigen bundle last-working-dir
antigen bundle tarruda/zsh-autosuggestions
antigen bundle arzzen/calc.plugin.zsh

zle-line-init() {
  zle autosuggest-start
}
zle -N zle-line-init

antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply

bindkey '^E' end-of-line

alias hd='xrandr --output HDMI3 --mode 1920x1080'
alias uhd='xrandr --output HDMI3 --mode 3840x2160'

alias rmo='sudo pacman -Rns $(pacman -Qdtq)'
alias lso='pacman -Qdtq'

alias lt='ls -ltrh'

alias f='find . -iname $*'

alias em='emacsclient -t $*'
alias eme='emacsclient -c $* &'

alias s='git status -s $*'
alias co='git checkout $*'
alias rb='git rebase $*'
alias l='git lg $*'
alias mg='git merge $*'
alias m='git commit -m $*'
alias am='git commit -am $*'
alias A='git add -A $*'
alias rs='git reset $*'
alias RSH='git reset --hard $*'
alias com='git commit $*'
alias con='git rebase --continue $*'





