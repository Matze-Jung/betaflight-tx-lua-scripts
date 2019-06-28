PageFiles =
{
    "pids1.lua",
    "pids2.lua",
    "rates.lua",
    "pid_advanced.lua",
    "filters.lua",
    "pwm.lua",
    "rx.lua",
    "vtx.lua",
    "rescue.lua",
    "gpspids.lua",
}

MenuBox = { x=120, y=100, w=200, x_offset=68, h_line=20, h_offset=6 }
SaveBox = { x=120, y=100, w=180, x_offset=12, h=60, h_offset=12 }
NoTelem = {   192,   LCD_H - 28, "No Telemetry", TEXT_COLOR + INVERS + BLINK }

ctrlSchema = {
    display = {
        prevPage = {
            cond = function(e, evs) return e == evs.press.pageUp end,
            func = function() stepPage(-1) end
        },
        nextPage = {
            cond = function(e, evs) return e == evs.press.pageDown end,
            func = function() stepPage(1) end
        },
        prevLine = {
            cond = function(e, evs) return e == evs.dial.left end,
            func = function() stepLine(-1) end
        },
        nextLine = {
            cond = function(e, evs) return e == evs.dial.right end,
            func = function() stepLine(1) end
        },
        edit = {
            cond = function(e, evs) return e == evs.release.enter end,
            func = function()
                setState("editing")
                setLock("editing.exit")
            end
        },
        menu = {
            cond = function(e, evs) return (evs.press.pageDown and e == evs.longPress.enter) or e == 1542 end, -- 1542 => [SYS]
            func = function()
                setState("displayMenu")
                setLock("displayMenu.exit")
            end
        },
        home = {
            cond = function(e, evs) return e == 1541 end, -- 1541 => [TELE]
            func = function()
                gotoPage(1)
            end
        },
        exit = {
            cond = function(e, evs) return e == evs.release.exit end,
            func = function() return protocol.exitFunc() end
        }
    },
    editing = {
        decValue = {
            cond = function(e, evs) return e == evs.release.plus end,
            func = function() stepValue(-1) end
        },
        stepValue = {
            cond = function(e, evs) return e == evs.release.minus end,
            func = function() stepValue(1) end
        },
        exit = {
            cond = function(e, evs) return e == evs.release.enter end,
            func = function() setState("display") end
        }
    },
    displayMenu = {
        prev = {
          cond = function(e, evs) return e == evs.dial.left end,
          func = function() stepMenu(-1) end
        },
        next = {
          cond = function(e, evs) return e == evs.dial.right end,
          func = function() stepMenu(1) end
        },
        cnfrm = {
            cond = function(e, evs) return e == evs.release.enter end,
            func = function() execMenu() end
        },
        exit = {
          cond = function(e, evs) return e == evs.release.exit or e == 1542 end, -- 1542 => [SYS]
          func = function() setState("display") end
        }
    }
}
