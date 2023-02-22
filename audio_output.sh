#! /usr/bin/env bash

# Query the list of all available sinks
choices="Laptop\nRazer Kraken"
chosen=$(echo -e "$choices" | dmenu -i)

case "$chosen" in 
	"Laptop") newDefaultSink=1;;
	"Razer Kraken") newDefaultSink=2;;
esac

pacmd set-default-sink $newDefaultSink

# Move all current playing streams to the new Default Sink
while read stream; do
	if [ -z "$stream" ]; then
		break 
	fi

	streamId=$(echo $stream | awk '{ print $1 }')
	pactl move-sink-input $streamId @DEFAULT_SINK@
done <<< "($pactl list short sink-inputs)"
