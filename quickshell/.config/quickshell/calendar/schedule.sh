#!/usr/bin/env bash
export TZ="Asia/Kolkata"

# Get today's and tomorrow's date
TODAY=$(date +%Y-%m-%d)
TOMORROW=$(date -d "tomorrow" +%Y-%m-%d)

# Helper to convert time to epoch
epoch() {
    date -d "$1 $2" +%s
}

cat << EOF
{
  "header": "JEE Grind — Daily Schedule",
  "link": "",
  "lessons": [
    {"type":"class","subject":"Wake Up","time":"7:45 AM - 8:00 AM","room":"","start":$(epoch $TODAY "07:45"),"end":$(epoch $TODAY "08:00"),"width":60,"is_compact":true},
    {"type":"class","subject":"Revision","time":"8:00 AM - 9:25 AM","room":"Short notes","start":$(epoch $TODAY "08:00"),"end":$(epoch $TODAY "09:25"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Leave for Gym","start":$(epoch $TODAY "09:25"),"end":$(epoch $TODAY "09:30"),"width":80},
    {"type":"class","subject":"Gym","time":"9:30 AM - 11:30 AM","room":"","start":$(epoch $TODAY "09:30"),"end":$(epoch $TODAY "11:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Shower & Breakfast","start":$(epoch $TODAY "11:30"),"end":$(epoch $TODAY "12:00"),"width":80},
    {"type":"class","subject":"Physics — Eduniti PYQ","time":"12:00 PM - 1:30 PM","room":"","start":$(epoch $TODAY "12:00"),"end":$(epoch $TODAY "13:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Lunch","start":$(epoch $TODAY "13:30"),"end":$(epoch $TODAY "14:00"),"width":60},
    {"type":"class","subject":"Maths — Neha ma'am","time":"2:00 PM - 3:00 PM","room":"","start":$(epoch $TODAY "14:00"),"end":$(epoch $TODAY "15:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Chemistry Questions","time":"3:00 PM - 4:00 PM","room":"","start":$(epoch $TODAY "15:00"),"end":$(epoch $TODAY "16:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Physics — Eduniti PYQ","time":"4:00 PM - 5:00 PM","room":"","start":$(epoch $TODAY "16:00"),"end":$(epoch $TODAY "17:00"),"width":140,"is_compact":false},
    {"type":"gap","desc":"Break","start":$(epoch $TODAY "17:00"),"end":$(epoch $TODAY "17:30"),"width":60},
    {"type":"class","subject":"Champs Course","time":"5:30 PM - 7:30 PM","room":"","start":$(epoch $TODAY "17:30"),"end":$(epoch $TODAY "19:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Dinner","start":$(epoch $TODAY "19:30"),"end":$(epoch $TODAY "20:00"),"width":60},
    {"type":"class","subject":"BITS Crash Course","time":"8:00 PM - 10:00 PM","room":"","start":$(epoch $TODAY "20:00"),"end":$(epoch $TODAY "22:00"),"width":160,"is_compact":false},
    {"type":"class","subject":"Maths — Neha ma'am","time":"10:00 PM - 11:00 PM","room":"","start":$(epoch $TODAY "22:00"),"end":$(epoch $TODAY "23:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Chemistry Questions","time":"11:00 PM - 12:15 AM","room":"","start":$(epoch $TODAY "23:00"),"end":$(epoch $TOMORROW "00:15"),"width":140,"is_compact":false},
    {"type":"class","subject":"LR / Question Solving","time":"12:15 AM - 1:00 AM","room":"","start":$(epoch $TOMORROW "00:15"),"end":$(epoch $TOMORROW "01:00"),"width":120,"is_compact":false},
    {"type":"class","subject":"Planning & Day Note","time":"1:00 AM - 1:30 AM","room":"","start":$(epoch $TOMORROW "01:00"),"end":$(epoch $TOMORROW "01:30"),"width":100,"is_compact":true}
  ]
}
EOF