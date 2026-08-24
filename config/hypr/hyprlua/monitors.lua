------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "2560x0",
    scale    = "auto",
})

hl.monitor({
    output   = "DP-2",
    mode     = "preferred",
    position = "0x0",
    scale    = "auto",
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1.33
})
