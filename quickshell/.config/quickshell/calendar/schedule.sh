#!/usr/bin/env bash
export TZ="Asia/Kolkata"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JSON="$SCRIPT_DIR/schedule.json"

TODAY=$(date +%Y-%m-%d)
TOMORROW=$(date -d "tomorrow" +%Y-%m-%d)

epoch() {
    local time="$2"
    # Times like 00:xx or 00:30 belong to tomorrow (past-midnight slots)
    local hour="${time%%:*}"
    if [ "$1" = "auto" ]; then
        if [ "$hour" -lt 5 ]; then
            date -d "$TOMORROW $time" +%s
        else
            date -d "$TODAY $time" +%s
        fi
    else
        date -d "$1 $time" +%s
    fi
}

# Read header from JSON
HEADER=$(jq -r '.header' "$JSON")
LINK=$(jq -r '.link' "$JSON")

# Build lessons array with live epoch timestamps
LESSONS=$(jq -c '.lessons[]' "$JSON" | while IFS= read -r lesson; do
    type=$(echo "$lesson" | jq -r '.type')
    start_time=$(echo "$lesson" | jq -r '.start_time')
    end_time=$(echo "$lesson" | jq -r '.end_time')
    width=$(echo "$lesson" | jq -r '.width')

    start_epoch=$(epoch auto "$start_time")

    # end_time: if it's earlier than start_time on the clock, it's tomorrow
    start_min=$(echo "$start_time" | awk -F: '{print $1*60+$2}')
    end_min=$(echo "$end_time"   | awk -F: '{print $1*60+$2}')
    if [ "$end_min" -le "$start_min" ] && [ "$end_min" -lt 300 ]; then
        end_epoch=$(date -d "$TOMORROW $end_time" +%s)
    else
        end_epoch=$(epoch auto "$end_time")
    fi

    if [ "$type" = "gap" ]; then
        desc=$(echo "$lesson" | jq -r '.desc')
        printf '{"type":"gap","desc":%s,"start":%d,"end":%d,"width":%d}\n' \
            "$(echo "$desc" | jq -Rs '.')" "$start_epoch" "$end_epoch" "$width"
    else
        subject=$(echo "$lesson" | jq -r '.subject')
        room=$(echo "$lesson"    | jq -r '.room')
        time_str=$(echo "$lesson" | jq -r '.time')
        is_compact=$(echo "$lesson" | jq -r '.is_compact')
        printf '{"type":"class","subject":%s,"time":%s,"room":%s,"start":%d,"end":%d,"width":%d,"is_compact":%s}\n' \
            "$(echo "$subject"  | jq -Rs '.')" \
            "$(echo "$time_str" | jq -Rs '.')" \
            "$(echo "$room"     | jq -Rs '.')" \
            "$start_epoch" "$end_epoch" "$width" "$is_compact"
    fi
done)

# Wrap into final JSON
printf '{\n  "header": %s,\n  "link": %s,\n  "lessons": [\n' \
    "$(echo "$HEADER" | jq -Rs '.')" \
    "$(echo "$LINK"   | jq -Rs '.')"

echo "$LESSONS" | awk 'NR>1{print "    " prev ","} {prev=$0} END{print "    " prev}'

printf '  ]\n}\n'