# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
#setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   correct
#setopt   correctall
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
unsetopt autocd
##############################
setopt   interactivecomments
##############################
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
#zmodload zsh/complist
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
setopt extendedglob
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zmodload zsh/complist
autoload colors
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'
zstyle ':completion:*' list-colors ''
##################
#[ -f /etc/DIR_COLORS ] && eval $$(dircolors -b /etc/DIR_COLORS) export ZLSCOLORS="$${LS_COLORS}" zmodload zsh/complist zstyle ':completion:*' list-colors $${(s.:.)LS_COLORS} zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*' completer _complete _match _approximate zstyle ':completion:*:match:*' original only zstyle ':completion:*:approximate:*' max-errors 1 numeric

#compdef pkill=kill compdef pkill=killall zstyle ':completion:*:*:kill:*' menu yes select zstyle ':completion:*:processes' command 'ps -au$$USER'

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile

PATH="$PATH:$HOME/.cabal/bin:$HOME/.scripts"
TZ="Asia/Taipei"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='emacs'
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%U%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
#LANGUAGE="zh_TW:zh:en"
#LANG='zh_TW.utf8'
LANGUAGE="ja_JP.utf8"
LANG='ja_JP.utf8'
LC_ALL="ja_JP.UTF-8"  ##這個不太清楚作用，總之註解掉不使用也是可以運作的。
LC_CTYPE='ja_JP.UTF-8'##這個也是。

if [ $SSH_TTY ]; then
  MUTT_EDITOR=vim
else
  MUTT_EDITOR=emacsclient.emacs-snapshot
fi


unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------

alias slrn="slrn -n"
#alias man='LC_ALL=C LANG=C man'
alias f=finger
alias ll='ls -al'
alias ls='ls --color=auto '
alias offlineimap-tty='offlineimap -u TTY.TTYUI'
alias hnb-partecs='hnb $HOME/partecs/partecs-hnb.xml'
alias rest2html-css='rst2html --embed-stylesheet --stylesheet-path=/usr/share/python-docutils/s5_html/themes/default/print.css'
#if [[ $HOSTNAME == "kamna" ]] {
#	alias emacs='emacs -l ~/.emacs.kamna'
#}

# alias	=clear

#chpwd() {
#     [[ -t 1 ]] || return
#     case $TERM in
#     sun-cmd) print -Pn "\e]l%~\e\\"
#     ;;
#    *xterm*|screen|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
#    ;;
#    esac
#}

#chpwd

autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORSe}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
       'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
       'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
       '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
       adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
       named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
       rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
       avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
       firebird gnats haldaemon hplip irc klog list man cupsys postfix\
       proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
       files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
       files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
       users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
       hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

function command_not_found_handle() {
    /usr/bin/python /usr/lib/command-not-found -- $1
}

alias emacs='emacs -nw'
alias ko='kde-open'
alias ta='if tmux attach-session -t 0;then;else tmux;fi'
alias lo='logout'
alias sudosynaptic='kdesudo -u root synaptic'
alias file-copy='rsync -rvtl --progress -L'
alias ptt='ssh bbsu@ptt.cc'
alias hx='hexo clean;hexo generate;hexo server --debug --drafts'
alias hxp='hexo clean;hexo generate;hexo server --debug'
alias hxd='hexo clean;hexo generate;hexo deploy'
alias t='timer 04:53'
alias dropboxd='~/.dropbox-dist/dropboxd &'
alias copyagent='~/.copy/x86_64/CopyAgent &'
# If adding a space in front of a command, the command won't be added into ~/.zsh_history
setopt hist_ignore_space

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# Compact, colorized git log
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glg="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --graph"
alias gb="git branch"
alias gc="git checkout"
alias gs="git status"

# List top ten largest files/directories in current directory
alias ducks='du -cks *|sort -rn|head -11'

alias hs='history | grep --color=auto'

# Open github web page of current git repo
alias githubopen="kde-open \`git remote -v | grep github.com | grep fetch | head -1 | field 2 | sed 's/git:/http:/g'\`"
alias rm='rm -I'


alias sys-suspend="dbus-send --print-reply --dest='org.freedesktop.PowerManagement' /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.Suspend"
# Disk load
alias dskload="ps faux|awk '\$8 ~ /D/{print}'"
hexo-new(){FILE=$1;emacs `hexo new "${FILE}" | grep -o "/.*.md$"`}

alias mergepdf='pdfunite'

# 沒啥屁用的dumpcore
#ulimit -c unlimited

alias rpmlargest="rpm -qa --queryformat '%10{SIZE}\t%{NAME}\n' | sort -k1,1n"
alias jk='jkbiv'
alias ff-addon-dev="cd ~/temp/addon-sdk-1.16/;source bin/activate;cd"
alias youtube='cd; youtube-dl --no-mtime'
alias yt='cd; youtube-dl --no-mtime'
alias youtube18='cd; youtube-dl --no-mtime -f 18'
alias youtube22='cd; youtube-dl --no-mtime -f 22'


newer (){ ls -dt "$@" | head -1 ;}
alias nr='newer'
alias nt='newer *'

alias delete-backup-files='find . -name "*~" | xargs rm'

cl() { cd "$@" && ls; }


alias source-venv='source ./venv/bin/activate'

# Settings for Wine
#export WINEARCH=win32

# ls after cd
function chpwd() {
    emulate -L zsh
    if [[ $(ls -a | wc -l) -lt 100 ]] ; then
        ls -a
    else
        echo ''
    fi
}


alias moni='cd ~/Django/Moni/Moni;source ../venv/bin/activate;./manage.py runserver'
alias alarm='countdown.rb -e "mplayer -volume 100 ${HOME}/音樂/Other/National\ Anthem\ of\ USSR.flv" -t "Wake Up!"'

TERM=xterm-256color

alias npm-venv='export PATH=$(npm bin):$PATH'
alias set-lang-to-en='LC_ALL=en_US.utf8;LANG=en_US.utf8;LANGUAGE=en_US.utf8'



eval $(thefuck --alias) in your ~/.zshrc
alias ff='firefox -P'


alias wine32='WINEPREFIX=~/.wine32;WINEARCH=win32;wine'
alias wine64='WINEPREFIX=~/.wine;WINEARCH= ;wine'


alias transcription-pdf-update='cp -u -v ~/University/Transcription/PDF/* ~/source-kuanyui.github.io/source/transcription/;cd ~/source-kuanyui.github.io/;npm-venv;hxd'
alias piano-save='cd ~/University/;git add *.mscz;git commit;bgit push'
alias zs='source ~/.zshrc'
