#!/bin/bash
if qs list --all 2>/dev/null | grep -q "quickshell/calendar"; then
    pkill -f "quickshell/calendar"
else
    qs -c calendar -n &
fi
