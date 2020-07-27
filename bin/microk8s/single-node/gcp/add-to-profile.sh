#!/bin/bash

cat <<EOT >> /home/${USER}/.profile

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)
alias memHogsTop='top -l 1 -o rsize | head -20'
alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
alias topForever='top -l 9999999 -s 10 -o cpu'
alias ttop="top -R -F -s 10 -o rsize"
alias myip='curl -k https://api.myip.com'                    # myip:         Public facing IP Address

alias di='docker images'

alias tf='terraform'

alias kgp='kubectl get pod'
alias kgpa='kubectl get pod --all-namespaces'
alias kdp='kubectl delete pod'
alias kgd='kubectl get deployment'
alias kdd='kubectl delete deployment'
alias ksvc='kubectl get services'
alias kdsvc='kubectl delete services'
alias kg='kubectl get'
alias kd='kubectl delete'
alias ke='kubectl exec -ti'
alias k='kubectl'
alias kl='kubectl logs'

alias hgv='helm get values'
alias hrl='helm repo list'
alias hra='helm repo add'
alias hrr='helm repo remove'
alias hru='helm repo update'
alias hsr='helm search repo'
alias hsv='helm show values'

alias mk="microk8s"

alias uatt='sudo apt update && sudo apt upgrade -y && sudo apt autoremove && snap refresh'

export TF_LOG_PATH=terraform.log
export TF_LOG=TRACE

export PATH="/usr/local/sbin:$PATH"
export PATH="${PATH}:${HOME}/.krew/bin"

EOT