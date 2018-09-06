#!/usr/bin/python3.6

import os, notify2
from time import sleep

percentageCommand = 'upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | grep -Eo "([0-9]{1,3})"'
stateCommand = 'upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | grep -Eo "((dis)?charging)"'

lowBatteryIcon = '/home/caleb/Pictures/icons/battery/battery-caution.png'
fullBatteryIcon = '/home/caleb/Pictures/icons/battery/battery-good.png'

notify2.init("Charge Cycle Preserver")
while True:
    percent = os.popen(percentageCommand).read()
    state = os.popen(stateCommand).read().strip()
    if state == 'charging':
        if int(percent) > 85:
            notify2.Notification('Above 85% stop charging', 'Remove charger to preserve power cycles', fullBatteryIcon).show()
    elif state == 'discharging':
        if int(percent) < 40:
            notify2.Notification('Below 40% start charging', 'Insert charger to preserve power cycles', lowBatteryIcon).show()
    sleep(30)
