git clone --bare https://bitbucket.org/durdn/cfg.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
config add .gdbinit
config add .i3blocks.con
config add .i3blocks.conf
config add .tmux
config add .tmux.conf
config add .gitignore
config add .vimrc
config add .vimrt
config add .xinitrc
config add .Xresources
config add .zprofile
config add .zshrc
config add .config/compton.conf
config add .config/termite
config add .config/i3
config add .config/i3blocks
