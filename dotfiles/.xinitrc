/usr/bin/start-pulseaudio-x11
xset s 300
##ssh-add -k ~/.ssh/id_rsa
if test "$ALT_WM" = "lxde"; then
	exec lxsession
else
	xwallpaper --maximize $HOME/dotfiles/dotfiles/Free-Hd-Nature-Mountain-River-Wallpaper.png
	dwmstatus 2>&1 >/dev/null &
	xcompmgr  2>&1 >/dev/null & # we need this to allow transperancy
	exec dwm
fi
	
