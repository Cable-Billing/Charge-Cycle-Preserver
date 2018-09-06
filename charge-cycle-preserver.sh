#!/bin/bash
PERCENT=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | grep -Eo "([0-9]{1,3})"`
STATE=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | grep -Eo "((dis)?charging)"`

if [[ $STATE == 'charging' ]]; then
    if [[ $PERCENT -gt 90 ]]; then
        notify-send -u "critical" -i /home/caleb/Pictures/icons/battery/battery-good.png "Above 90% stop charging" "Remove charger to preserve power cycles"
        echo "above"
    fi
elif [[ $STATE == 'discharging' ]]; then
    if [[ $PERCENT -lt 40 ]]; then
        notify-send -u "critical" -i /home/caleb/Pictures/icons/battery/battery-caution.png "Below 40% start charging" "Insert charger to preserve power cycles"
        echo "below"
    fi
fi
