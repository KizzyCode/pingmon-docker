#!/bin/sh
set -eu


# Creates a timestamp
timestamp() {
    date "+%Y.%m.%d-%Hh%Mm%Ss%Z"
}


# Get the host or use "heise.de" as fallback
HOST="${HOST:-heise.de}"

# Create the logfiles
LOGFILE="/var/pingmon/pingmon-`timestamp`.log"
ERRFILE="/var/pingmon/pingmon-`timestamp`.err.log"
:> "$LOGFILE"
:> "$ERRFILE"

# Main-loop
while true; do
    # Perform one ping and wait for up to one second for a reply
    if ping -c 1 -w 1 "$HOST" 2>/dev/null >/dev/null; then
        # Ping completed
        TIMESTAMP=`timestamp`
        echo "$TIMESTAMP,success" >> "$LOGFILE"
    else
        # Ping failed
        TIMESTAMP=`timestamp`
        echo "$TIMESTAMP,failure" >> "$LOGFILE"
        echo "$TIMESTAMP,failure" >> "$ERRFILE"
    fi

    # Sleep one second because we don't want to flood THE INTERNET™️ in case of immediate success or failure
    sleep 1
done
