#!/bin/bash

yesno() {

    if [[ ! -z "$SKIP_QUESTION" ]]; then
        return 1
    fi
    while true; do
        read -r -n 1 -p "[-] $1 [Y/n] " resp
        echo " "
        case "$resp" in
            [nN])
            return 1
            ;;
            [yY])
            return 0
            ;;
            "")
            return 0
            ;;
            *)
            echo "[#] Please answer with [yn]"
            ;;
        esac
    done
}

trycmd() {
    if [[ "$DEBUG" -eq "1" ]]; then
        echo "[DBG] $@"
    else
        $@ || { echo "[#] Terminating! Failed to execute $@" ; exit 2; }
    fi
}

runif() {
    # if /usr/bin/$1 exists run the command
    #if [[ -e "/usr/bin/$1" ]]; then
    #    trycmd ${@:2}
    #fi
    which $1 > /dev/null && trycmd ${@:2}
}

dohelp() {
    echo "Usage: $0 [OPTIONS]"
    echo -e "-df,--dot-files path:\n\tpath to the root directory of the dotfiles"
    echo -e "-b,--backup path:\n\tpath to the backup dir (default ~/.backup_dot)"
    echo -e "-d,--debug:\n\tdebug/dry run, commands are only printed and not executed"
    echo -e "-co,--config-only:\n\tinstall steps are skipped, only the dotfiles symlinked"
    echo -e "-s,--skip-config:\n\tskip updating symlinks"
    echo -e "-a,--all:\n\tinstall everything"
    echo -e "-ib,--install-base:\n\tinstall basic required packages"
    echo -e "-id,--install-build:\n\tinstall build tools"
    echo -e "-ix,--install-x:\n\tinstall x server"
}

# TODO parse command line for options
DOTFILES=~/.dotfiles
BACKUP=~/.backup_dot
DEBUG=0

while [[ $# -gt 0 ]]; do
    key=$1
    case $key in
        -d|--debug)
            DEBUG=1
            ;;
        -df|--dot-files)
            DOTFILES=$2
            if [[ ! -d "$DOTFILES" ]]; then
               echo "[#] directory $DOTFILES does not exist"
               exit 3
            fi
            shift
            ;;
        -b|--backup)
            BACKUP=$2
            shift
            ;;
        -co|--config-only)
            CONFIG_ONLY=1
            #SKIP_QUESTION=1
            ;;
        -s|--skip-config)
            SKIP_CONFIG=1
            ;;
        -ib|--install-base)
            INSTALL_BASE=1
            SKIP_QUESTION=1
            ;;
        -id|--install-build)
            INSTALL_BUILD=1
            SKIP_QUESTION=1
            ;;
        -ix|--install-x)
            INSTALL_X=1
            SKIP_QUESTION=1
            ;;
        -a|-all)
            INSTALL_BASE=1
            INSTALL_X=1
            INSTALL_BUILD=1
            SKIP_QUESTION=1
            ;;
        -h|--help)
            dohelp
            exit 3
            ;;
        *)
            echo "[#] Unknown paramter: $key"
            dohelp
            exit 3
            ;;
    esac
    shift
done
# get the distro installer
APT=$(which apt-get)
PAC=$(which pacman)

if [[ ! -z "$APT" ]]; then
    echo "[*] Installing on Debian/Ubuntu based VM"
elif [[ ! -z "$PAC" ]]; then
    echo "[*] Installing on Arch"
else
    echo "[#] Error unsupported distro"
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    echo "[*] Running as root..."
    SUDO=""
else
    SUDO="sudo"
fi



# installing dist packages
if [[ -z "$CONFIG_ONLY" ]] && ( yesno "Do you want to install dist packages?" || [[ ! -z "$SKIP_QUESTION" ]] ) ; then
    echo "[*] Installing dist packages"
    echo "[*] Updating package repos"

    if [[ ! -z "$APT" ]]; then
        trycmd "$SUDO apt-get update"
    elif [[ ! -z "$PAC" ]]; then
        # have to upgrade, partial upgrades suck
        trycmd "$SUDO pacman -Syu"
    fi
    
    if [[ ! -z "$INSTALL_BASE" ]] || yesno "Install essentials (vim, git, zsh, tmux)?" ; then
        echo "[*] Installing essentials"
         
        if [[ ! -z "$APT" ]]; then
            trycmd "$SUDO apt-get -y install git vim zsh tmux"
        elif [[ ! -z "$PAC" ]]; then
            # have to upgrade, partial upgrades suck
            trycmd "$SUDO pacman -S --noconfirm git vim zsh tmux"
        fi
    fi
    # TODO add basic build tools, make, cmake, gcc, python2-3, pip, virtual env
    if [[ ! -z "$INSTALL_BUILD" ]] || yesno "Install build tools (TODO)?" ; then
        echo "[*] Installing build tools"
        echo "[#] Skipping TODO"
    fi

    if [[ ! -z "$PAC" ]] && ( [[ ! -z "$INSTALL_X"  ]] || yesno "Install xorg and i3?" ); then
        echo "[*] installing xorg"
        trycmd "$SUDO pacman -S --noconfirm xorg-server xorg-server-utils xorg-xinit xterm xorg-twm xorg-xclock"
        # TODO add mesa+gpu drivers
        # TODO add git install for i3 and i3 blocks
        # update /etc/profile
        echo "[*] updateing /etc/profile"
        # No trycmd here, f*** that escaping hell
        if [[ "$DEBUG" -ne 1 ]]; then
            echo '# autostart systemd default session on tty1
            if [[ \"$(tty)\" == \"/dev/tty1\" ]]; then
                exec startx
            fi' | $SUDO tee -a /etc/profile
        fi
    fi
    # TODO install yaourt + update conf
    # TODO install userspace (see arch inst)
    # TODO install basic dbg (gdb, peda, pwntools, capstone, pwndbg, libc src)

fi

# install the actual config (symlinks)
if [[ -z "$SKIP_CONFIG" ]];then

    #files="bashrc vimrc vim zshrc oh-my-zsh"    # list of files/folders to symlink in homedir
    declare -A config=( ["vim"]="vim/vimrc;.vimrc vim/vimrc2;.vimrc" )

    # create dotfiles_old in homedir
    echo "[*] Creating $BACKUP for backup of any existing dotfiles in ~"
    trycmd "mkdir -p $BACKUP"

    # TODO clone the dotfiles directory if needed

    # change to the dotfiles directory
    echo "[*] Changing to the $DOTFILES directory"
    trycmd "cd $DOTFILES"

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
    for app in ${!config[@]}; do
        for file in ${config[$app]}; do
            echo "$file"
            IFS=';' read src dst <<< "$file"
            
            # TODO check if installed
            echo "Moving any existing dotfile to $BACKUP"
            # TODO leave it alone if already simlinked
            runif $app "mv -r ~/$dst $BACKUP"
            echo "Creating symlink to $file in home directory."
            runif $app "ln -s $DOTFILES/$src ~/$dst"
        done
    done
fi
