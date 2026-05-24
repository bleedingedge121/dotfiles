hl.monitor({
    output = "eDP-1",          
    mode = "1920x1080@60",     
    position = "0x0",           
    scale = 1.25,                  
})

-- Global input config
hl.config({
    input = {
        sensitivity = 0, 
    },
})

-- Per-device config (DeathadderEssential shows up as multiple nodes)
local mice = {
    "razer-razer-deathadder-essential",
    "razer-razer-deathadder-essential-1",
    "razer-razer-deathadder-essential-2",
    "razer-razer-deathadder-essential-3",
}

for _, name in ipairs(mice) do
    hl.device({
        name        = name,
        sensitivity = -0.6,
    })
end