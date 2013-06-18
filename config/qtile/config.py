  # !/usr/bin/env python
# -*- coding: utf-8 -*-
from libqtile import bar, hook, layout, widget
from libqtile.command import lazy
from libqtile.config import Group, Key, Match, Screen

import custom


class Commands:
    volume_up = 'amixer -q -c 0 sset Master 5dB+'
    volume_down = 'amixer -q -c 0 sset Master 5dB-'
    volume_toggle = 'amixer -q -c 0 sset Master toggle'


##-> Keybindings
ALT = 'mod1'
MOD = 'mod4'
keys = [
    ## Window Manager Controls
    Key([MOD, 'control'], 'r', lazy.restart()),
    Key([MOD, 'control'], 'q', lazy.shutdown()),

    ## Window Controls
    Key([MOD], 'q', lazy.window.kill()),
    Key([MOD], 'F12', lazy.window.toggle_fullscreen()),
    #Key([MOD], 'Left', lazy.group.prevgroup()),
    #Key([MOD], 'Right', lazy.group.nextgroup()),

    ## Volume Controls
    Key([], 'XF86AudioRaiseVolume', lazy.spawn(Commands.volume_up)),
    Key([], 'XF86AudioLowerVolume', lazy.spawn(Commands.volume_down)),
    Key([], 'XF86AudioMute', lazy.spawn(Commands.volume_toggle)),

    Key([MOD], 'Return', lazy.spawn('urxvt')),
    Key([MOD], 'n', lazy.spawn('chromium')),
    Key([MOD], 'r', lazy.spawncmd(prompt=':')),

    ## Layout, group, and screen modifiers
    Key([MOD], 'k', lazy.layout.up()),
    Key([MOD], 'j', lazy.layout.down()),
    Key([MOD], 'h', lazy.layout.previous()),
    Key([MOD], 'l', lazy.layout.next()),
    Key([ALT], 'Tab', lazy.nextlayout()),

    #Key([MOD, 'shift'], 'space', lazy.layout.rotate()),
    #Key([MOD, 'shift'], 'Return', lazy.layout.toggle_split()),

    #Key([MOD], 'h', lazy.to_screen(1)), # left
    #Key([MOD], 'l', lazy.to_screen(0)), # right

    Key([MOD, 'control'], 'l', lazy.spawn('xscreensaver-command -lock')),
]

group_setup = (
    ('main', {
        'layout': 'tile',
    }),
    ('dev', {
        'layout': 'max',
    }),
    ('www', {
        'layout': 'max',
        'match': [Match(title=r'Chromium')],
    }),
    ('im', {
        'layout': 'max',
        'match': [Match(title='Buddy List')],
    }),
    ('vm', {
        'layout': 'max',
    }),
)

groups = []
for idx, (name, config) in enumerate(group_setup):
    hotkey = str(idx + 1)
    groups.append(Group(name, layout=config.get('layout', 'tile'), matches=config.get('match', None)))
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
        widget.Prompt(**theme),
        widget.WindowName(**theme),
        #widget.CurrentLayout(**theme),
        widget.CPUGraph(**theme),
        widget.MemoryGraph(**theme),
        widget.Sep(**theme),
        custom.BetterBattery(**theme),
        widget.Sep(**theme),
        widget.Systray(**theme),
        widget.Sep(**theme),
        widget.Clock(fmt='%I:%M %p', **theme),
    ], 30)),
]

layouts = (
    layout.Tile(),
    layout.Max(),
)

floating_layout = layout.floating.Floating(float_rules=[{'wmclass': x} for x in (
    'Download',
    'dropbox',
    'file_progress',
    'file-roller',
    'Komodo_confirm_repl',
    'Komodo_find2',
    'pidgin',
    'Update',  # Komodo update window
    'Xephyr',
)])


@hook.subscribe.client_new
def floating_dialogs(window):
    dialog = window.window.get_wm_type() == 'dialog'
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True
