# -*- coding: utf-8 -*-

import os

from i3pystatus import Status
from i3pystatus.core.modules import IntervalModule


class JuniperVPN(IntervalModule):

    interval = 5
    up_face = '◕ ◡ ◕'
    down_face = '◕︵◕'

    def run(self):
        try:
            networks = os.listdir('/var/run/juniper')
        except OSError:
            networks = []
        self.output = {
            'full_text': '{} {}'.format(self.up_face, ' '.join(networks))
                         if networks else self.down_face,
        }


status = Status(standalone=True)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
                format="%a %-d %b %X")

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
                format="{temp:.0f}°C",)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via dbus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
status.register("battery",
                format="{status}/{consumption:.2f}W {percentage:.2f}% "
                       "{remaining:%E%hh:%Mm}",
                alert=True,
                alert_percentage=5,
                status={
                    "DIS": "↓",
                    "CHR": "↑",
                    "FULL": "=",
                })

status.register(JuniperVPN())

status.run()
