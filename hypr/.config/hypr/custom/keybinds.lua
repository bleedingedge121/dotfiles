hl.bind("CTRL+SUPER+ALT+Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"), {description = "Edit user keybinds"} )


--##! Apps
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd("~/.local/bin/toggle-calendar.sh"), { description = "Calendar" })
hl.bind("SUPER + S", hl.dsp.exec_cmd("superproductivity"), { description = "Super Productivity" })
hl.bind("SUPER + ALT + O", hl.dsp.exec_cmd("obsidian"), { description = "Obsidian" })