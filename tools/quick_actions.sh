#!/bin/bash

if [ -n "$1" ]
then
	ACTION=$1
else
  ACTION=$(echo -e "Dark Mode\nLight Mode\nTurn laptop screen on\nTurn laptop screen off\nColor Picker"| fuzzel --dmenu "Choose:")
fi

case "$ACTION" in
  "Dark Mode")
      echo "dark" > /tmp/sylscheme
      # plasma-apply-lookandfeel -a com.github.vinceliuice.WhiteSur-dark && plasma-apply-cursortheme oreo_blue_cursors
      # Set mode for GTK3 applications. Install arc-gtk-theme, because there is no Adwaita-dark theme anymore
          gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
      # Set mode for GTK4 applications
          niri msg action do-screen-transition && gsettings set org.gnome.desktop.interface color-scheme prefer-dark

      # Switch wallpaper
          ln -sf "$HOME"/Pictures/wally/wall_dark.* "$HOME"/Pictures/wally/wall
          systemctl restart --user swaybg
      # # Set brightness
      #     brightnessctl -q s 12
      # Set mako
          makoctl mode -s dark
      # Set fuzzel
          ln -sf "$HOME"/.config/fuzzel/dark_fuzzel.ini "$HOME"/.config/fuzzel/fuzzel.ini
      # Set foot
          ln -sf "$HOME"/.config/foot/foot_dark.ini "$HOME"/.config/foot/foot.ini
      # pkill -USR1 zsh # check foot wiki for day night # warning zsh closes, solution is theme.sh

      # waybar
          ln -sf "$HOME"/.config/waybar/style_dark.css "$HOME"/.config/waybar/style.css
       killall -SIGUSR2 waybar

      # Notification (for debug purposes)
          notify-send -c "system" "  Dark mode"
    ;;
    "Light Mode")
      echo "light" > /tmp/sylscheme
      # plasma-apply-lookandfeel -a com.github.vinceliuice.WhiteSur-alt && plasma-apply-cursortheme oreo_blue_cursors
      # Make sure that you set env variable QT_QPA_PLATFORMTHEME=gtk3 for QT applications
      # Set mode for GTK3 applications
          gsettings set org.gnome.desktop.interface gtk-theme Adwaita
      # Set mode for GTK4 applications
          niri msg action do-screen-transition && gsettings set org.gnome.desktop.interface color-scheme prefer-light

      # Switch wallpaper
          ln -sf "$HOME"/Pictures/wally/wall_light.* "$HOME"/Pictures/wally/wall
          systemctl restart --user swaybg
      # # Set brightness
      #     brightnessctl -q s 14
      # Set mako
          makoctl mode -r dark
      # Set fuzzel
          ln -sf "$HOME"/.config/fuzzel/light_fuzzel.ini "$HOME"/.config/fuzzel/fuzzel.ini
      # Set foot
          ln -sf "$HOME"/.config/foot/foot_light.ini "$HOME"/.config/foot/foot.ini
      # pkill -USR1 zsh # check foot wiki for day night; see dark

      # waybar
          ln -sf "$HOME"/.config/waybar/style_light.css "$HOME"/.config/waybar/style.css
       killall -SIGUSR2 waybar

      # Notification
          notify-send -c "system" "  Light mode"
    ;;
    "Turn laptop screen off")
      niri msg output eDP-1 off
      notify-send "Turing off"
    ;;
    "Turn laptop screen on")
      niri msg output eDP-1 on
      notify-send "Turing on"
    ;;
    "Color Picker")
      sh ~/sylveryte/dotfiles/tools/screentools.sh colorpick
    ;;
esac
echo scheme is $scheme
