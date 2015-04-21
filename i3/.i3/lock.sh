#!/bin/sh
IMAGEMAGIK_CMD='convert $f -scale 10% -scale 1000% ~/.i3/lock.png -gravity center -composite -matte $f'
scrot /tmp/lockscreen.png -e "$IMAGEMAGIK_CMD"
i3lock -i /tmp/lockscreen.png
