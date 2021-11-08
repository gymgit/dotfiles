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

testvm() {
    local stat=$(hostnamectl status | grep -i chassis)
    local chass=${stat##* }
    if [[ "$chass" == "vm" ]]; then
        return 0
    else
        return 1
    fi
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

install_dein(){
    DEINDIR="$DOTFILES/vim/vimrt/plugins/repos/github.com/Shougo/dein.vim"
    if [[ ! -e $DEINDIR ]]; then
        echo "[*] Installing dein Vim plugin manager"
        trycmd git clone https://github.com/Shougo/dein.vim $DEINDIR
        trycmd mkdir -p "$DOTFILES/vim/vimrt/temp_dirs"
        ## notes TODO fix in deinconf
        # run git submodule update --init --recursive in youcomplete me
        # install clang + mono
        # run pythin install.py --omnisharp-completer --clang-completer
        # on ARCH
        # run pythin install.py --omnisharp-completer --clang-completer --system-libclang
        # in vim :call dein#update()

    else
        echo "[*] Dein already installed skipping"
    fi

}

install_oh_my_zsh(){
    if [[ ! -e ~/.oh-my-zsh ]]; then
        echo "[*] Installing oh-my-zsh"
        if [[ "$DEBUG" -eq "1" ]]; then
            echo '[DBG] sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
        else
            # because executing scripts from the internet is ever fun
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        fi
    else
        echo "[*] Oh-my-zsh already installed skipping"
    fi
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

parse_arg() {
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
}

get_dist() {
    # get the distro installer
    APT=$(which apt-get 2> /dev/null)
    PAC=$(which pacman)

    if [[ ! -z "$APT" ]]; then
        echo "[*] Installing on Debian/Ubuntu based VM"
    elif [[ ! -z "$PAC" ]]; then
        echo "[*] Installing on Arch"
    else
        echo "[#] Error unsupported distro"
        exit 1
    fi
}

install_packages() {
    echo "[*] Installing dist packages"
    #echo "[*] Updating package repos"

    #if [[ ! -z "$APT" ]]; then
    #    trycmd "$SUDO apt-get update"
    #elif [[ ! -z "$PAC" ]]; then
        # have to upgrade, partial upgrades suck
    #    trycmd "$SUDO pacman -Syu"
    #fi
    
    if [[ ! -z "$PAC" ]] && ( [[ ! -z "$INSTALL_BASE"  ]] || yesno "Create dir layout?" ); then
        trycmd "mkdir -p $HOME/dev"
        trycmd "mkdir -p $HOME/doc"
        trycmd "mkdir -p $HOME/dwnload"
        trycmd "mkdir -p $HOME/ctf"
        trycmd "mkdir -p $HOME/rand"
        trycmd "mkdir -p $HOME/progs/inst"
        trycmd "mkdir -p $HOME/progs/src"
        trycmd "mkdir -p $HOME/progs/win"
        trycmd "mkdir -p $HOME/.bin"
        trycmd "mkdir -p $HOME/rand/mnt"
        trycmd "mkdir -p $HOME/rant/screenshots"
    fi

    if [[ ! -z "$INSTALL_BASE" ]] || yesno "Install essentials (vim, git, zsh, tmux, curl, wget)?" ; then
        echo "[*] Installing essentials"
         
        if [[ ! -z "$APT" ]]; then
            trycmd "$SUDO apt-get -y install git vim zsh tmux curl wget"
        elif [[ ! -z "$PAC" ]]; then
            trycmd "$SUDO pacman -S --noconfirm --needed git vim zsh tmux curl wget"
        fi
    fi

    if [[ ! -z "$INSTALL_BUILD" ]] || yesno "Install build tools (make cmake clang gcc g++ gdb-multiarch python2 python3 python2-pip python3-pip virtualenv virtualenvwrapper)?" ; then
        echo "[*] Installing build tools"
        if [[ ! -z "$APT" ]]; then
            trycmd "$SUDO apt-get -y install make cmake clang gcc g++ gdb-multiarch python python3 python-pip python3-pip virtualenv virtualenvwrapper"
            [[ -e ~/.venvs ]] && trycmd "mkdir $HOME/.venvs"
        elif [[ ! -z "$PAC" ]]; then
            trycmd "$SUDO pacman -S --noconfirm --needed make cmake clang gcc gdb python python2 python-pip python2-pip python-virtualenv python-virtualenvwrapper python2-virtualenv man-db man-pages ctags"
            trycmd "$SUDO pacman -S --noconfirm --needed rust rust-racer mono mono-tools boost"
            [[ -e ~/.venvs ]] && trycmd "mkdir $HOME/.venvs"
        fi

        # TODO install ncurse 5 compat
        # 
        # trycmd "trizen -S --noconfirm --needed ncurses5-compat-libs " 
    fi

    # install vbox guest stuff
    if testvm && ( [[ ! -z "$INSTALL_VBGUEST" ]] || yesno "Install vbox guest tools?" ); then
        echo "[*] Installing virtualbox guest additions"
         
        if [[ ! -z "$APT" ]]; then
            #trycmd "$SUDO apt-get -y install build-essential module-assistant virtualbox-guest-dkms virtualbox-guest-utils"
            trycmd "$SUDO apt-get -y install build-essential virtualbox-guest-x11"
        elif [[ ! -z "$PAC" ]]; then
            trycmd "$SUDO pacman -S --noconfirm --needed virtualbox-guest-utils"
        fi
    fi

    if [[ ! -z "$PAC" ]] && ( [[ ! -z "$INSTALL_REST"  ]] || yesno "Install trizen and update conf?" ); then
    trycmd "$SUDO sed -i s/#[multilib]\n#Include/[multilib]\nInclude/g /etc/pacman.conf"
    cwd=$PWD
    trycmd "mkdir -p $HOME/progs/inst"
    cd ~/progs/inst
    trycmd "git clone https://aur.archlinux.org/trizen.git"
    trycmd "cd trizen"
    trycmd "makepkg -si"
    trycmd "trizen -Syu -a"
    cd $cwd

    fi

    if [[ ! -z "$PAC" ]] && ( [[ ! -z "$INSTALL_X"  ]] || yesno "Install xorg and i3?" ); then
        echo "[*] installing xorg"
        trycmd "$SUDO pacman -S --noconfirm --needed xorg-server xorg-apps xorg-xinit xterm xorg-twm xorg-xclock xsel arandr"
        trycmd "$SUDO pacman -S --noconfirm --needed xorg-fonts-misc ttf-hack ttf-dejavu ttf-inconsolata ttf-freefont ttf-fira-code noto-fonts font-mathematica" # ttf-hack ttf-symbola"
        trycmd "$SUDO pacman -S --noconfirm --needed i3-gaps rofi i3status i3lock-color compton dunst"
        trycmd "$SUDO pacman -S --noconfirm --needed xorg-fonts-misc ttf-font-awesome powerline-fonts" # ttf-hack ttf-symbola"
        #trycmd "trizen -S i3blocks-gaps-git nerd-fonts-complete"
        trycmd "trizen -S --noconfirm --needed polybar"
        trycmd "trizen -S --noconfirm --needed nerd-fonts-hack papirus-icon-theme"
        #trycmd "trizen -S --noconfirm nerd-fonts-complete" #this is broken right now has also grown way too big

        #    trycmd "$SUDO pacman -S --noconfirm --needed nvidia"

        # trycmd + install yaourt first
        # yaourt -S i3-gaps-git
        #spwd=`pwd`
        trycmd "$SUDO pacman -S --noconfirm --needed acpi bc lm_sensors openvpn playerctl sysstat scrot imagemagick"

        #git clone https://github.com/Airblader/i3blocks-gaps.git ~/progs/install/i3block
        #cd ~/progs/install/i3block
        #make clean all
        #$SUDO make install
        #cd $spwd
        trycmd "trizen -S --noconfirm --needed betterlockscreen"
        # trizen -S betterlockscreen
        #git clone https://github.com/pavanjadhaw/betterlockscreen
        # cp betterlockscreen/betterlockscreen
        # update /etc/profile
        echo "[*] updating /etc/profile"
        # No trycmd here, f*** that escaping hell
        if [[ "$DEBUG" -ne 1 ]]; then
            echo '# autostart systemd default session on tty1
            if [[ "$(tty)" == "/dev/tty1" ]]; then
                exec startx
            fi' | $SUDO tee -a /etc/profile
        fi
    fi

    if [[ ! -z "$PAC" ]] && ( [[ ! -z "$INSTALL_REST"  ]] || yesno "Install progs?" ); then
        # TODO auto detect video card
        # PRogs to add:
        # Install graphics:
        # pacman -S mesa nvidia bumblebee xf86-video-intel lib32-virtualgl lib32-nvidia-utils mesa-demos primus lib32-primus bbswitch
        # gpasswd -a gym bumblebee
        # systemctl enable bumblebee
        # Intel Graphics:
        # add xf86-video-intel?
        trycmd "$SUDO pacman -S --noconfirm --needed alsa-firmware alsa-utils alsa-plugins pulseaudio-alsa pulseaudio pavucontrol"
        trycmd "$SUDO pacman -S --noconfirm --needed openssh wireshark-qt dnsutils gnu-netcat nmap socat wireguard-tools wireguard-arch traceroute"
        if ! testvm; then
            trycmd "$SUDO pacman -S --noconfirm --needed mesa lib32-mesa vulkan-intel"
            trycmd "$SUDO pacman -S --noconfirm --needed xf86-video-intel"
            trycmd "$SUDO pacman -S --noconfirm --needed virtualbox virtualbox-host-modules-arch"
        else
            trycmd "$SUDO pacman -S --noconfirm --needed xf86-video-vmware"
        fi
        # TODO add trizen for virtualbox extras
        trycmd "$SUDO pacman -S --noconfirm --needed keepassxc"
        trycmd "$SUDO pacman -S --noconfirm --needed unzip rsync"
        trycmd "$SUDO pacman -S --noconfirm --needed deluge firefox chromium "
        trycmd "$SUDO pacman -S --noconfirm --needed evince nitrogen ranger termite feh"
        trycmd "$SUDO pacman -S --noconfirm --needed vlc ffmpeg"
        # trizen spotify pulseaudio-ctl
        trycmd "$SUDO pacman -S --noconfirm --needed texlive-core texlive-bibtexextra texlive-fontsextra texlive-formatsextra texlive-pictures texlive-pstricks texlive-latexextra"

        trycmd "$SUDO pacman -S --noconfirm --needed vlc ffmpeg"
        # terminal smartness
        trycmd "$SUDO pacman -S --noconfirm --needed fzf ripgrep the_silver_searcher bat mlocate highlight fd"
        # TODO install ctf tools
        # TODO install basic dbg (gdb, peda, pwntools, capstone, pwndbg, libc src)
        # -S python-pwntools
        # pwntools, pwndbg, afl (on host), preeny, qemu, angr
        trycmd "$SUDO pacman -S --noconfirm --needed python-pwntools qemu"
        trycmd "trizen -S --noconfirm --needed pwndbg gdb-multiarch"
        # install gvim for more features
        trycmd "$SUDO pacman -S --noconfirm --needed gvim"
        
    fi

    # TODO research tools

    # trizen: simg-tools setools



    #pacman -S steam ttf-liberation wqy-zenhei steam-native-runtime


    # TODO install userspace (see arch inst)
    # chromium yolo: chromium-widevine pepper-flash spotify



    # TODO 32 bit packages, lib32-nvidia-utils
    #INSTALL office tools libreoffice dia latex graphviz

    # TODO install skype with flatpak -- flatpak run --talk-name=org.gnome.keyring com.skype.Client
    # install gnome-keyring, seahorse, libsecret
    # edit pam /etc/pam.d/passwd <-- password   optional    pam_gnome_keyring.so
    # run 
}
    



install_config() {
    #files="bashrc vimrc vim zshrc oh-my-zsh"    # list of files/folders to symlink in homedir
    MACHINE='vm'
    if [[ $(hostname) == "LaptopArch" ]]; then
        MACHINE='laptop'
    elif [[ $(hostname) == "MableArch" ]] || [[ $(hostname) == "castillo" ]]; then
        MACHINE='worklt2'
    elif [[ $(hostname) == "worklt" ]]; then
        MACHINE='worklt'
    fi
    
    declare -A config=( ["vim"]="vim/vimrc;.vimrc vim/vimrt;.vimrt"\
        ["tmux"]="tmux/tmux.conf;.tmux.conf tmux/tmux;.tmux tmux/tmux/tmux_init.sh;.bin/tmx"\
        ["compton"]="compton/compton.conf;.config/compton.conf"\
        ["zsh"]="zsh/zprofile;.zprofile zsh/zshrc;.zshrc zsh/profile;.profile"\
        ["Xorg"]="Xorg/Xresources;.Xresources"\
        ["i3"]="i3/xinitrc;.xinitrc i3;.config/i3 i3/config.$MACHINE;.config/i3/config.local bin/lock_screen.sh;.bin/lock_screen.sh"\
        ["i3blocks"]="i3blocks/i3blocks.conf.$MACHINE;.i3blocks.conf i3blocks;.config/i3blocks"\
        ["polybar"]="polybar/polybar.sh;.bin/polybar.sh polybar/config;.config/polybar/config"\
        ["termite"]="termite;.config/termite"\
        ["dunst"]="dunst;.config/dunst")

    # create dotfiles_old in homedir
    echo "[*] Creating $BACKUP for backup of any existing dotfiles"
    trycmd "mkdir -p $BACKUP"

    echo "[*] Creating ~/.config for directory" 
    trycmd "mkdir -p $HOME/.config"
    trycmd "mkdir -p $HOME/.config/polybar"
    # TODO clone the dotfiles directory if needed
    # TODO install ubuntu VM systemd startup + script (/usr/local/sbin/ubuntu_startup)

    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
    for app in ${!config[@]}; do
        echo "[*] Trying to install config for $app"
        # check if app is installed
        if [[ ! -z `command -v $app` ]]; then
            # this is a temporary hack
            if [[ "$app" == "vim" ]]; then
                #install_dein
                echo "TODO install vim plugins"
            elif [[ "$app" == "zsh" ]]; then
                install_oh_my_zsh
            fi
            for file in ${config[$app]}; do
                IFS=';' read src dst <<< "$file"
                #echo "$app $src $dst"
                # TODO leave it alone if already simlinked
                [[ -e ~/$dst ]] && echo "[*] Moving ~/$dst to $BACKUP"
                [[ -e ~/$dst ]] && trycmd "mv $HOME/$dst $BACKUP/"
                
                echo "[*] Creating symlink to $DOTFILES/$src <- ~/$dst"
                trycmd "ln -s $DOTFILES/$src $HOME/$dst"
            done
        else
            echo "[*] $app is not installed. Skipping..."
        fi
    done

    # TODO symlink ./bin stuff
}

main() {
    parse_arg "${@}"
    get_dist

    if [[ $EUID -eq 0 ]]; then
        echo "[*] Running as root..."
        SUDO=""
    else
        SUDO="sudo"
    fi

    # installing dist packages
    if [[ -z "$CONFIG_ONLY" ]] && ( yesno "Do you want to install dist packages?" || [[ ! -z "$SKIP_QUESTION" ]] ) ; then
        install_packages
    fi

    # install the actual config (symlinks)
    if [[ -z "$SKIP_CONFIG" ]] && ( yesno "Do you want to install config links?" || [[ ! -z "$SKIP_QUESTION" ]] ) ; then
        install_config
    fi
}

if [ "${1}" != "--source-only" ]; then
    main "${@}"
fi
