import os

from libqtile import bar, manager
from libqtile.widget import base

CHARGING = 'Charging'
DISCHARGING = 'Discharging'
FULL = 'Full'
DEPLETED = 'Depleted'
UNKNOWN = 'Unknown'
BATTERY_DIR = '/sys/class/power_supply'


class BetterBattery(base._TextBox):
    defaults = manager.Defaults(
        ("font", "Arial", "Battery widget font"),
        ("fontsize", None, "Battery widget pixel size. Calculated if None."),
        ("padding", None, "Battery widget padding. Calculated if None."),
        ("background", "000000", "Background colour"),
        ("foreground", "ffffff", "Foreground colour"),
        ("low_foreground", "FF0000", "font when battery is low"),
        ("format", "{char} {percent:2.0%} {hour:d}:{min:02d}", "Display format"),
        ("battery_name", "BAT0", "ACPI name of a battery, usually BAT0"),
        ("status_file", "status", "Name of status file in /sys/class/power_supply/battery_name"),
        ("energy_now_file", "energy_now", "Name of file with the current energy in /sys/class/power_supply/battery_name"),
        ("energy_full_file", "energy_full", "Name of file with the maximum energy in /sys/class/power_supply/battery_name"),
        ("power_now_file", "power_now", "Name of file with the current power draw in /sys/class/power_supply/battery_name"),
        ("update_delay",1,"The delay in seconds between updates"),
        ("charge_char","^","Character to indicate the battery is charging"),
        ("discharge_char","V","Character to indicate the battery is discharging"),

    )

    FRMTS = {
        FULL: '%(char)s %(percent)2.0d%%',
        CHARGING: '%(char)s %(percent)2.0d%% %(hours)02d:%(mins)02d',
        DISCHARGING: '%(char)s %(percent)2.0d%% %(hours)02d:%(mins)02d',
        UNKNOWN: '%(percent)2.0d%%',
        DEPLETED: 'depleted',
    }

    def __init__(self, width=bar.CALCULATED, **config):
        base._TextBox.__init__(self, 'BAT', **config)

    def _configure(self, qtile, bar):
        base._TextBox._configure(self, qtile, bar)
        self.timeout_add(1, self.update)

    def _read(self, base, *args):
        for arg in args:
            path = os.path.join(base, arg)
            if os.path.exists(path):
                return open(path).read().strip()
        raise IOError('File(s) not found')

    def status(self, path):
        state = self._read(path, 'status')
        now = float(self._read(path, 'energy_now', 'charge_now'))
        full = float(self._read(path, 'energy_full', 'charge_full'))
        power = float(self._read(path, 'power_now', 'current_now'))

        if state == DISCHARGING:
            time = now / power
            char = '-'
        elif state == CHARGING:
            time = (full - now) / power
            char = '+'
        elif state == UNKNOWN:
            time = 0
            char = ''
        else:
            time = 0
            char = '~'
            if now > 0:
                state = FULL
            else:
                state = DEPLETED

        hours, mins = int(time), int(time * 60) % 60

        return {
            'state': state,
            'char': char,
            'percent': (now / full) * 100,
            'hours': hours,
            'mins': mins,
        }

    def batteries(self):
        batteries = [(path, os.path.join(BATTERY_DIR, path))
                     for path in os.listdir(BATTERY_DIR)
                     if path != 'AC']
        return reversed(sorted(batteries, key=lambda x: x[0]))

    def info(self):
        statuses = []
        for _, path in self.batteries():
            status = self.status(path)
            frmt = self.FRMTS[status['state']]
            statuses.append(frmt % status)
        return ' | '.join(statuses)

    def update(self):
        next_status = self.info()
        if next_status != self.text:
            self.text = next_status
            self.bar.draw()
        return True

if __name__ == '__main__':
    bb = BetterBattery()
    print bb.info()
