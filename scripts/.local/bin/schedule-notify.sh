#!/usr/bin/env bash
export TZ="Asia/Kolkata"

LOG="$HOME/.cache/schedule-notify.log"
echo "Started at $(date)" >> "$LOG"

get_schedule() {
    bash ~/.config/quickshell/calendar/schedule.sh
}

notify_event() {
    TYPE=$1
    SUBJECT=$2
    TIME=$3

    if [ "$TYPE" = "class" ]; then
        ICON="📚"
        MSG="$SUBJECT\n$TIME"
    else
        ICON="⏸️"
        MSG="$SUBJECT"
    fi

    notify-send -u normal "$ICON Starting Now" "$MSG" -t 10000
}

notify_warning() {
    TYPE=$1
    SUBJECT=$2
    TIME=$3

    if [ "$TYPE" = "class" ]; then
        ICON="📚"
    else
        ICON="⏸️"
    fi

    notify-send -u low "⏰ 10 mins — $SUBJECT" "$TIME" -t 8000
}

CURRENT_DAY=$(date +%Y-%m-%d)
SCHEDULE=$(get_schedule)

while true; do
    # Reload schedule at midnight
    TODAY=$(date +%Y-%m-%d)
    if [ "$TODAY" != "$CURRENT_DAY" ]; then
        SCHEDULE=$(get_schedule)
        CURRENT_DAY=$TODAY
        echo "$(date): Reloaded schedule for $TODAY" >> "$LOG"
    fi

    NOW=$(date +%s)
    NEXT_SLEEP=300  # default sleep 5 min

    while IFS= read -r lesson; do
        TYPE=$(echo "$lesson" | jq -r '.type')
        START=$(echo "$lesson" | jq -r '.start')

        if [ "$TYPE" = "class" ]; then
            SUBJECT=$(echo "$lesson" | jq -r '.subject')
            TIME=$(echo "$lesson" | jq -r '.time')
        else
            SUBJECT=$(echo "$lesson" | jq -r '.desc')
            TIME=""
        fi

        DIFF=$((START - NOW))

        # Notify at start
        if [ "$DIFF" -ge 0 ] && [ "$DIFF" -le 60 ]; then
            echo "$(date): Notifying $SUBJECT" >> "$LOG"
            notify_event "$TYPE" "$SUBJECT" "$TIME"
        fi

        # Notify 10 min before
        DIFF10=$((START - NOW - 600))
        if [ "$DIFF10" -ge 0 ] && [ "$DIFF10" -le 60 ]; then
            echo "$(date): 10min warning $SUBJECT" >> "$LOG"
            notify_warning "$TYPE" "$SUBJECT" "$TIME"
        fi

        # Calculate smart sleep — wake up just before next event
        if [ "$DIFF" -gt 60 ] && [ "$DIFF" -lt "$NEXT_SLEEP" ]; then
            NEXT_SLEEP=$((DIFF - 55))
        fi
        if [ "$DIFF10" -gt 60 ] && [ "$DIFF10" -lt "$NEXT_SLEEP" ]; then
            NEXT_SLEEP=$((DIFF10 - 55))
        fi

    done <<< "$(echo "$SCHEDULE" | jq -c '.lessons[]')"

    # Never sleep more than 5 minutes or less than 10 seconds
    [ "$NEXT_SLEEP" -gt 300 ] && NEXT_SLEEP=300
    [ "$NEXT_SLEEP" -lt 10 ] && NEXT_SLEEP=10

    echo "$(date): Sleeping ${NEXT_SLEEP}s" >> "$LOG"
    sleep "$NEXT_SLEEP"
done