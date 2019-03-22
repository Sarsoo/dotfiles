#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar top &

if [[ "$(hostname)" == "andy-pc"  ]]; then
	for m in $(polybar --list-monitors | cut -d":" -f1); do
    		MONITOR=$m IFACE="eno1" polybar --reload top &
	done
else
	for m in $(polybar --list-monitors | cut -d":" -f1); do
    		MONITOR=$m IFACE="wlp3s0" polybar --reload top &
	done
fi	



echo "Bars launched..."
