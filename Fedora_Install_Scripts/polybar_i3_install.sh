#* Install Dependencies
#!/usr/bin/sh
sudo dnf install alacritty nitrogen gnome-screenshot redshift arandr gnome-screenshot
#Install base files
sudo dnf install vlc polybar rofi pasystray blueman git lxappearance lsd

mkdir -p ~/.config/polybar/
cd ..
ln -s $(pwd)/polybar/laptop_config ~/.config/polybar/config.ini

mkdir -p ~/.config/i3/
rm ~/.config/i3/config
ln -s $(pwd)/i3/laptop_config ~/.config/i3/config