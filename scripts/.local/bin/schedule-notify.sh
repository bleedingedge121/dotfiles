#!/usr/bin/env bash
export TZ="Asia/Kolkata"

LOG="$HOME/.cache/schedule-notify.log"
echo "Started at $(date)" >> "$LOG"

while true; do
    NOW=$(date +%s)
    SCHEDULE=$(bash ~/.config/quickshell/calendar/schedule.sh)
    
    if [ -z "$SCHEDULE" ]; then
        echo "$(date): Schedule empty!" >> "$LOG"
        sleep 30
        continue
    fi

    while IFS= read -r lesson; do
        START=$(echo "$lesson" | jq -r '.start')
        SUBJECT=$(echo "$lesson" | jq -r '.subject')
        TIME=$(echo "$lesson" | jq -r '.time')
        
        DIFF=$((START - NOW))
        if [ "$DIFF" -ge 0 ] && [ "$DIFF" -le 60 ]; then
            echo "$(date): Notifying $SUBJECT" >> "$LOG"
            notify-send -u normal "📚 Starting Now" "$SUBJECT\n$TIME" -t 10000
        fi
        
        DIFF5=$((START - NOW - 300))
        if [ "$DIFF5" -ge 0 ] && [ "$DIFF5" -le 60 ]; then
            echo "$(date): 5min warning $SUBJECT" >> "$LOG"
            notify-send -u low "⏰ Starting in 5 mins" "$SUBJECT\n$TIME" -t 8000
        fi
        
    done <<< "$(echo "$SCHEDULE" | jq -c '.lessons[] | select(.type == "class")')"
    
    sleep 30
done