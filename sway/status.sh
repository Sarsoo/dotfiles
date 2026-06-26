date_formatted=$(date '+%a %F %H:%M')

# "upower --enumerate | grep 'BAT'" gets the battery name (e.g.,
# "/org/freedesktop/UPower/devices/battery_BAT0") from all power devices.
# "upower --show-info" prints battery information from which we get
# the state (such as "charging" or "fully-charged") and the battery's
# charge percentage. With awk, we cut away the column containing
# identifiers. i3 and sway convert the newline between battery state and
# the charge percentage automatically to a space, producing a result like
# "charging 59%" or "fully-charged 100%".
battery_info=$(upower -i $(upower -e | grep 'bat') | grep -E "percentage" | awk '{print $2}' | cut -d '.' -f1)

# battery_info=$(upower --show-info $(upower --enumerate |\
# grep 'bat') |\
# grep -E "state|percentage" |\
# awk '{print $2}')

echo "${battery_info}% 🔋 ${date_formatted}"
