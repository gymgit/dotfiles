wget https://installerstorage.blob.core.windows.net/public/install/tresorit_installer.run
mkdir /opt/tresorit
chown -R gym:users /opt/tresorit
echo -e "y\n/opt/tresorit\nn\n" | sh tresorit_installer.run
ln -s /opt/tresorit/tresorit ~/.bin/tresorit
