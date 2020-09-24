#!/bin/sh

# miha X startup script
xset s 300
xclock -geometry 100x100-100+1 &
xterm -geometry 80x24 &
xconsole -iconic &
exec fvwm

