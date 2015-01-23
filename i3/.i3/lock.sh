#!/bin/sh
scrot /tmp/lockscreen.png -e 'convert $f -blur 8x8 $f'
i3lock -i /tmp/lockscreen.png
