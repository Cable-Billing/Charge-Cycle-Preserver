#!/bin/bash

while [[ true ]]; do
    PERCENT=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep percentage | grep -Eo "([0-9]{1,3})"`
    STATE=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep state | grep -Eo "((dis)?charging)"`
    if [[ $STATE == 'charging' ]]; then
        if [[ $PERCENT -gt 85 ]]; then
            notify-send -u "critical" -i $PWD/icons/battery-good.png "Above 85% stop charging" "Remove charger to preserve power cycles"
        fi
    elif [[ $STATE == 'discharging' ]]; then
        if [[ $PERCENT -lt 40 ]]; then
            notify-send -u "critical" -i $PWD/icons/battery-caution.png "Below 40% start charging" "Insert charger to preserve power cycles"
        fi
    fi
    sleep 30
done
