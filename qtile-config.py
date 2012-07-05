#!/usr/bin/env python
# -*- coding: utf-8 -*-

from libqtile import bar, hook, layout, widget
from libqtile.command import lazy
from libqtile.manager import Drag, Click, Group, Key, Screen

    #volume_up = 'amixer -q -c 0 sset Master 5dB+'
    #volume_down = 'amixer -q -c 0 sset Master 5dB-'
    #volume_toggle = 'amixer -q -c 0 sset Master toggle'


##-> Keybindings
MOD = 'mod4'
keys = [
    ## Window Manager Controls
    Key([MOD, 'control'], 'r', lazy.restart()),
    Key([MOD, 'control'], 'q', lazy.shutdown()),

    ## Window Controls
    Key([MOD], 'w', lazy.window.kill()),
    Key([MOD], 'Left', lazy.group.prevgroup()),
    Key([MOD], 'Right', lazy.group.nextgroup()),

    ## Volume Controls
    #Key([], 'XF86AudioRaiseVolume', lazy.spawn(Commands.volume_up)),
    #Key([], 'XF86AudioLowerVolume', lazy.spawn(Commands.volume_down)),
    #Key([], 'XF86AudioMute', lazy.spawn(Commands.volume_toggle)),

    Key([MOD], 'Return', lazy.spawn('terminal')),

    ## Layout, group, and screen modifiers
    #Key([MOD], 'j', lazy.layout.up()),
    #Key([MOD], 'k', lazy.layout.down()),
    #Key([MOD, 'shift'], 'j', lazy.layout.shuffle_up()),
    #Key([MOD, 'shift'], 'k', lazy.layout.shuffle_down()),
    #Key([MOD, 'shift'], 'g', lazy.layout.grow()),
    #Key([MOD, 'shift'], 's', lazy.layout.shrink()),
    #Key([MOD, 'shift'], 'n', lazy.layout.normalize()),
    #Key([MOD, 'shift'], 'm', lazy.layout.maximize()),
    #Key([MOD, 'shift'], 'space', lazy.layout.flip()),

    #Key([MOD], 'space', lazy.layout.next()),
    #Key([MOD], 'Tab', lazy.nextlayout()),

    #Key([MOD, 'shift'], 'space', lazy.layout.rotate()),
    #Key([MOD, 'shift'], 'Return', lazy.layout.toggle_split()),

    #Key([MOD], 'h', lazy.to_screen(1)), # left
    #Key([MOD], 'l', lazy.to_screen(0)), # right

    Key([MOD, 'control'], 'l', lazy.spawn('xscreensaver-command -lock')),
]

group_setup = (
    ('main', {}),
    ('dev', {
        'layout': 'max',
        'apps': {'wm_class': ('Komodo Edit',)},
        }),
    ('www', {
        'layout': 'max',
        'apps': {'wm_class': ('Firefox', 'Google-chrome')},
    }),
    ('im', {'layout': 'max'}),
    ('vm', {
        'layout': 'max',
        'apps': {'wm_class': ('VirtualBox',)},
    }),
)

groups = []
for idx, (name, config) in enumerate(group_setup):
    hotkey = str(idx + 1)
    groups.append(Group(name, layout=config.get('layout', 'tile')))
    keys.append(Key([MOD], hotkey, lazy.group[name].toscreen()))
    keys.append(Key([MOD, 'shift'], hotkey, lazy.window.togroup(name)))

##-> Screens
theme = {
    'fontsize': 12,
    'font': 'ttf-droid',
}

screens = [
    Screen(top=bar.Bar([
        widget.GroupBox(**theme),
        widget.WindowName(**theme),
        widget.CurrentLayout(**theme),
        widget.Systray(**theme),
        widget.Sep(**theme),
        widget.Battery(**theme),
        widget.Clock(**theme),
    ], 30)),
]

layouts = (
    layout.Tile(ratio=0.5),
    layout.Max(),
)

floating_layout = layout.floating.Floating(float_rules=[{'wmclass': x} for x in (
    'Download',
    'dropbox',
    'file_progress',
    'file-roller',
    'gimp',
    'Komodo_confirm_repl',
    'Komodo_find2',
    'pidgin',
    'Update', # Komodo update window
    'Xephyr',
    )])

@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True

@hook.subscribe.startup
def runner():
    import shlex
    import subprocess

    preface = [
        'feh --bg-scale /home/mtomwing/.config/qtile/wallpaper.jpg',
    ]
    for command in preface:
        args = shlex.split(command)
        try:
            subprocess.call(args)
        except OSError as e:
            print e
