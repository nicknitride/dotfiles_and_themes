#!/usr/bin/sh
mkdir -p ~/.config/alacritty/
echo "ln -s $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml"
ln -s $(pwd)/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

mkdir -p ~/.config/i3/config
echo "ln -s $(pwd)/i3/config ~/.config/i3/config"
ln -s $(pwd)/i3/config ~/.config/i3/config

mkdir -p ~/.config/polybar/
echo "ln -s $(pwd)/polybar/polybar_config ~/.config/polybar/config.ini"
ln -s $(pwd)/polybar/polybar_config ~/.config/polybar/config.ini