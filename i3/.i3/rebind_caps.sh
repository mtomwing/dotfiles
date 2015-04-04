#!/bin/sh
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'clear Lock'
xmodmap -e 'add Control = Control_L'
xcape -e 'Control_L=Escape'
xcape -e '#66=Escape'
