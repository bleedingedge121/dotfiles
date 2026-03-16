#!/usr/bin/env bash
export TZ="Asia/Kolkata"

TODAY=$(date +%Y-%m-%d)
TOMORROW=$(date -d "tomorrow" +%Y-%m-%d)

epoch() {
    date -d "$1 $2" +%s
}

cat << EOF
{
  "header": "JEE Grind",
  "link": "",
  "lessons": [
    {"type":"class","subject":"Wake Up","time":"6:45 AM - 7:00 AM","room":"","start":$(epoch $TODAY "06:45"),"end":$(epoch $TODAY "07:00"),"width":60,"is_compact":true},
    {"type":"class","subject":"Revision","time":"7:00 AM - 7:45 AM","room":"Short notes","start":$(epoch $TODAY "07:00"),"end":$(epoch $TODAY "07:45"),"width":120,"is_compact":false},
    {"type":"class","subject":"Physics — Eduniti PYQ","time":"7:45 AM - 9:45 AM","room":"","start":$(epoch $TODAY "07:45"),"end":$(epoch $TODAY "09:45"),"width":160,"is_compact":false},
    {"type":"class","subject":"Chemistry Questions","time":"9:45 AM - 11:00 AM","room":"","start":$(epoch $TODAY "09:45"),"end":$(epoch $TODAY "11:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Maths","time":"11:00 AM - 1:30 PM","room":"","start":$(epoch $TODAY "11:00"),"end":$(epoch $TODAY "13:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Lunch","start":$(epoch $TODAY "13:30"),"end":$(epoch $TODAY "14:00"),"width":60},
    {"type":"class","subject":"Physics — Eduniti PYQ","time":"2:00 PM - 4:00 PM","room":"","start":$(epoch $TODAY "14:00"),"end":$(epoch $TODAY "16:00"),"width":160,"is_compact":false},
    {"type":"class","subject":"Chemistry Questions","time":"4:00 PM - 5:30 PM","room":"","start":$(epoch $TODAY "16:00"),"end":$(epoch $TODAY "17:30"),"width":140,"is_compact":false},
    {"type":"gap","desc":"Break / Snack","start":$(epoch $TODAY "17:30"),"end":$(epoch $TODAY "18:00"),"width":60},
    {"type":"class","subject":"Champs Course","time":"6:00 PM - 7:30 PM","room":"","start":$(epoch $TODAY "18:00"),"end":$(epoch $TODAY "19:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Dinner","start":$(epoch $TODAY "19:30"),"end":$(epoch $TODAY "20:00"),"width":60},
    {"type":"class","subject":"BITS Crash Course","time":"8:00 PM - 9:30 PM","room":"","start":$(epoch $TODAY "20:00"),"end":$(epoch $TODAY "21:30"),"width":160,"is_compact":false},
    {"type":"class","subject":"Chemistry Questions","time":"9:30 PM - 11:15 PM","room":"","start":$(epoch $TODAY "21:30"),"end":$(epoch $TODAY "23:15"),"width":140,"is_compact":false},
    {"type":"class","subject":"Maths — Neha ma'am","time":"11:15 PM - 12:45 AM","room":"","start":$(epoch $TODAY "23:15"),"end":$(epoch $TOMORROW "00:45"),"width":160,"is_compact":false},
    {"type":"class","subject":"Planning & Day Note","time":"12:45 AM - 1:00 AM","room":"","start":$(epoch $TOMORROW "00:45"),"end":$(epoch $TOMORROW "01:00"),"width":100,"is_compact":true}
  ]
}
EOF