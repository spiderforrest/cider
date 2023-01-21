#!/bin/bash

# spider's unified ~/.bashrc

### setup/misc ###

# i want these to be available in non-interactive enviorments
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.nimble/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export EDITOR=nvim

# ignore the rest if not interactive
[[ $- != *i* ]] && return

# prompt
PS1='\[\e[0;31m\]mine@legtwo \[\e[0m\]@ \[\e[0;36m\]\w \[\e[0m\]\$ \[\e[0m\]'

# history configs
export HISTCONTROL=ignoreboth
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
HISTFILESIZE=-1

# autocomplete after sudo, man, so on
complete -cf sudo
complete -cf man
complete -cf which

### functions ###

# history but less obnoxious
hst() {
    if [[ -n "$1" ]] ; then
        cat -n "$HOME/.bash_history" | grep -a "$1" | tail -n 40
    else
        history | tail -n 40
    fi
}

# git gud
shove() {
    git pull
    git add -A
    git status
    if [[ "$1" ]] ; then
        echo '/// continue? ///'
    if git status | grep -q main ; then
        echo '/// and you'\''re on main you nincompoop ///'
    fi
        read -r
        git commit -m "$*"
        git push
        return
    fi
    echo '/// so help me god if you put something lazy ///'
    if git status | grep -q main ; then
        echo '/// and you'\''re on main you nincompoop ///'
    fi
    read -r message
    git commit -m "$message"
    git push
}
github() {
    if [[ -z $1 ]] ; then return ; fi
    cd ~/project/git || return
    if echo "$1" | grep -q http; then
        text=$(git clone "$1" 2>&1 >/dev/null)
    else
        text=$(git clone "https://github.com/$1.git" 2>&1 >/dev/null)
    fi
    dir=$(echo "$text" | grep -oE "'([^']*)'")
    cd "$dir" || return
    alacritty &
    alacritty &
}


# consolidates ls,cat,mkdir,vim,touch,cd,vim again
uh() {
    # check second arg for edit/enter flag for editing existing files or moving directories-saves me like four keypresses to just append 'v' or 'e' when uh-ing aroud to edit
    if [[ -n "$2" ]] ; then
        if [[  "$2" = "v" || "$2" = "e" ]] ; then
            nvim "$1"
        else
            # run arbitrary command on $1
            shift 1
            "$*" "$1"
        fi
        return
    fi
    # bootleg case statement operating on what the target is
    # ls PWD if no input
    if [[ -z "$1" ]] ; then
        ls -ZlAhcbGNp --color=always --group-directories-first --time-style=+%y/%m/%d\.%H%M --hyperlink=auto | tac
        # ls target if existing dir
    elif [[ -d "$1" ]] ; then
        ls -ZlAhcbGNp --color=always --group-directories-first --time-style=+%y/%m/%d\.%H%M --hyperlink=auto "$1" | tac
        # cat target if textfile
    elif [[ -f "$1" ]] ; then
        cat "$1"
        # the shellcheck warning annoys me a lot more than it should
        printf "/// %s ///\n" "$(ls -abhHiluZ --color=always --group-directories-first --time-style=+%y/%m/%d\.%H%M --hyperlink=auto "$1" | tac)"
        # make directory or make/edit file
    elif [[ ! -e "$1" ]] ; then
        printf "/// does not exist! create \"%s\" as a directory open a new file ///\n  for editor(assumed): *\n  for mkdir: d(irectory),m(kdir)\\n  for touch: t(ouch)\\n  cancel: n(o),c(ancel)\n" "$1"
        read -r i
        case "$i" in
            n* | c*)	return								;;
            d* | m*)	mkdir -p "$1" && cd "$1" || return	;;
            t*)         touch "$1"                          ;;
            *)			nvim "$1"							;;
        esac
    fi
}

# extract script bc fuck remembering that
extract() {
    case "$1" in
        *.tar.bz2)   tar xvjf "$1"				;;
        *.tar.gz)    tar xvzf "$1"				;;
        *.bz2)       bunzip2 "$1" 				;;
        *.rar)       unrar x "$1" 				;;
        *.gz)        gunzip "$1"  				;;
        *.tar)       tar xvf "$1" 				;;
        *.tbz2)      tar xvjf "$1"				;;
        *.tgz)       tar xvzf "$1"				;;
        *.zip)       unzip "$1"   				;;
        *.Z)         uncompress "$1"			;;
        *.7z)        7z x "$1"					;;
        *) echo "that's unknownski my broski" 	;;
    esac
}

### aliasi ###

# shorthands
alias v='nvim'
alias vw='nvim -u $HOME/.config/synced/writing.vim'
alias suv='sudoedit'
alias chkdns='ping 8.8.8.8'
alias la='ls -Bbp1 -gah --group-directories-first --time-style=+%b\ %d --color=auto --hyperlink=auto'
alias ls='ls -BNp1 --group-directories-first --color=auto --hyperlink=auto'
alias ch='chore'
alias godo='chore'
alias gitfix='sed -i s/mindforrest/spiderforrest/ */.git/config'
alias binfix='chmod +x ~/bin/* && cd ~/bin'
alias fastread='fsrx'
alias serv='ssh spider@spood.org -p 773'
alias fserv='sftp -P 773 spider@spood.org'
alias why_would_you_do_this_dude_why='xclip -o | shuf'
cfg() { nvim "$HOME/.config/synced/$1"; }
alias :q="exit" # ...

alias sconsole='screen -rS survival'
alias cconsole='screen -rS creative'

# fixes/improvements
alias sl='sl -la'
alias rm='rm -rI'
alias grep='grep --color=auto'
alias btop='btop --utf-force'
# alias sudo !!
alias !='sudo /bin/bash -c "$(history -p !!)"'
# allow aliasi to apply after sudo
alias sudo="/bin/sudo "
# some files start with a bit of garbo bytes, grep misbehaves to protect output but i ain't a pussy
alias grep='grep -a'

# less color spam
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# attempt to set the terminal title
trap 'echo -ne "\033]2;Alacritty | $(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g")\007"' DEBUG

# MOTD
printf "welcome to the minecraft(and other games) host user! reminders: screen -rS [creative, survival, etc] to attach and ctrl-a is the screen leader, and d is detatch\nuse cconsole and sconsole to access the minecraft consoles\no/\n"
#EOF
