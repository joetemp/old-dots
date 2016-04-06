#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &
xrdb -merge ~/.Xresources &

# This sets my monitor order.

xrandr --output DP-0 --auto --output HDMI-0 --auto --primary  --right-of DP-0 --output DVI-I-1 --auto --right-of HDMI-0 &

# This sets my wallpaper.

feh --bg-scale --no-xinerama ~/pictures/wallpapers/solarized.jpg
sh ~/.fehbg &

#This makes sure my fonts are found by X
xset +fp ~/.local/share/fonts

# This launches my WM and hotkey daemon. 

sxhkd -f 100 &
compton --backend glx --paint-on-overlay --vsync opengl -b -c &  
exec bspwm 
