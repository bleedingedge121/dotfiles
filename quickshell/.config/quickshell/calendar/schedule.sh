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
    {"type":"class","subject":"Revision","time":"7:00 AM - 7:30 AM","room":"Short notes","start":$(epoch $TODAY "07:00"),"end":$(epoch $TODAY "07:30"),"width":100,"is_compact":false},
    {"type":"class","subject":"Maths — BITSAT Drill","time":"7:30 AM - 9:30 AM","room":"Timed MCQ sets","start":$(epoch $TODAY "07:30"),"end":$(epoch $TODAY "09:30"),"width":160,"is_compact":false},
    {"type":"class","subject":"Physics — BITSAT Drill","time":"9:30 AM - 11:00 AM","room":"Single-correct, past papers","start":$(epoch $TODAY "09:30"),"end":$(epoch $TODAY "11:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Chemistry — BITSAT Drill","time":"11:00 AM - 12:30 PM","room":"Rotate Org / Inorg / Physical","start":$(epoch $TODAY "11:00"),"end":$(epoch $TODAY "12:30"),"width":140,"is_compact":false},
    {"type":"gap","desc":"Lunch","start":$(epoch $TODAY "12:30"),"end":$(epoch $TODAY "13:15"),"width":60},
    {"type":"class","subject":"JEE Advanced — Maths","time":"1:15 PM - 3:00 PM","room":"Multi-correct, integer type","start":$(epoch $TODAY "13:15"),"end":$(epoch $TODAY "15:00"),"width":160,"is_compact":false},
    {"type":"class","subject":"BITS Crash Course","time":"3:00 PM - 4:30 PM","room":"Theory intake","start":$(epoch $TODAY "15:00"),"end":$(epoch $TODAY "16:30"),"width":160,"is_compact":false},
    {"type":"gap","desc":"Break / Snack","start":$(epoch $TODAY "16:30"),"end":$(epoch $TODAY "17:00"),"width":60},
    {"type":"class","subject":"Maths — BITSAT Drill","time":"5:00 PM - 6:30 PM","room":"","start":$(epoch $TODAY "17:00"),"end":$(epoch $TODAY "18:30"),"width":160,"is_compact":false},
    {"type":"class","subject":"Physics — BITSAT Drill","time":"6:30 PM - 7:30 PM","room":"","start":$(epoch $TODAY "18:30"),"end":$(epoch $TODAY "19:30"),"width":140,"is_compact":false},
    {"type":"gap","desc":"Dinner","start":$(epoch $TODAY "19:30"),"end":$(epoch $TODAY "20:00"),"width":60},
    {"type":"class","subject":"BITS Crash Course","time":"8:00 PM - 9:30 PM","room":"Theory intake","start":$(epoch $TODAY "20:00"),"end":$(epoch $TODAY "21:30"),"width":160,"is_compact":false},
    {"type":"class","subject":"JEE Advanced — Physics","time":"9:30 PM - 11:00 PM","room":"Paragraph, multi-correct","start":$(epoch $TODAY "21:30"),"end":$(epoch $TODAY "23:00"),"width":160,"is_compact":false},
    {"type":"class","subject":"JEE Advanced — Chemistry","time":"11:00 PM - 12:00 AM","room":"","start":$(epoch $TODAY "23:00"),"end":$(epoch $TOMORROW "00:00"),"width":140,"is_compact":false},
    {"type":"class","subject":"Chemistry — BITSAT Drill","time":"12:00 AM - 12:30 AM","room":"","start":$(epoch $TOMORROW "00:00"),"end":$(epoch $TOMORROW "00:30"),"width":100,"is_compact":true},
    {"type":"class","subject":"Planning & Day Note","time":"12:30 AM - 1:00 AM","room":"","start":$(epoch $TOMORROW "00:30"),"end":$(epoch $TOMORROW "01:00"),"width":100,"is_compact":true}
  ]
}
EOF
