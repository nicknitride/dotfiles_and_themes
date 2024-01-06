#!/usr/bin/sh
mkdir -p ~/.config/alacritty/
echo "ln -s $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/"
ln -s $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/

mkdir -p ~/.config/i3/config
echo "ln -s $(pwd)/i3/config ~/.config/i3/"
ln -s $(pwd)/i3/config ~/.config/i3/

mkdir -p ~/.config/polybar/
echo "ln -s $(pwd)/polybar/polybar_config ~/.config/polybar/config.ini"
ln -s $(pwd)/polybar/polybar_config ~/.config/polybar/config.ini