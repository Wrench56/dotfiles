notify-send -t 5000 -u low -i boot "System booted" "Welcome aboard!" &
xrandr | grep -c "[HDMI|VGA|DP]-[0-9] connected" > /tmp/monitors-connected &
~/.fehbg &
exec i3