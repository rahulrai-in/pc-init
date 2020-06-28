#!/bin/sh

FORECAST=$(curl wttr.in?format="%C+%t+%m+%w")

WIDTH=${1}

SMALL=80
MEDIUM=107
LARGE=125

if [ "$WIDTH" -ge "$LARGE" ]; then
    DATE="#[fg=colour255] $(date +'%a %d/%m/%y') $FORECAST"
fi

if [ "$WIDTH" -ge "$MEDIUM" ]; then
    TIME="#[fg=colour255]$(date +'%H:%M')"
fi

if [ "$WIDTH" -ge "$SMALL" ]; then
    CLEAR=""
fi

echo "$DATE $TIME" | sed 's/ *$/ /g'
