#!/usr/bin/env bash
export TZ="Asia/Kolkata"

SCHEDULE=$(bash ~/.config/quickshell/calendar/schedule.sh)

while true; do
    NOW=$(date +%s)
    
    # Get all class items
    LESSONS=$(echo "$SCHEDULE" | jq -c '.lessons[] | select(.type == "class")')
    
    while IFS= read -r lesson; do
        START=$(echo "$lesson" | jq -r '.start')
        SUBJECT=$(echo "$lesson" | jq -r '.subject')
        TIME=$(echo "$lesson" | jq -r '.time')
        
        # Notify exactly when class starts (within 60 second window)
        DIFF=$((START - NOW))
        if [ "$DIFF" -ge 0 ] && [ "$DIFF" -le 60 ]; then
            notify-send -u normal -i "x-office-calendar" "📚 Starting Now" "$SUBJECT\n$TIME" -t 10000
        fi
        
        # Also notify 5 minutes before
        DIFF5=$((START - NOW - 300))
        if [ "$DIFF5" -ge 0 ] && [ "$DIFF5" -le 60 ]; then
            notify-send -u low -i "x-office-calendar" "⏰ Starting in 5 mins" "$SUBJECT\n$TIME" -t 8000
        fi
        
    done <<< "$LESSONS"
    
    sleep 30
done