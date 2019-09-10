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

MenuBox = { x= (LCD_W -200)/2, y=LCD_H/2, w=200, x_offset=68, h_line=20, h_offset=6 }
SaveBox = { x= (LCD_W -200)/2, y=LCD_H/2, w=180, x_offset=12, h=60, h_offset=12 }
NoTelem = { LCD_W/2 - 50, LCD_H - 28, "No Telemetry", TEXT_COLOR + INVERS + BLINK }

-- !TODO: X7 schema here, no clue about Nirvana yet
ctrlSchema = {
    display = {
        prevPage = {
            cond = function(e, evs) return e == evs.longPress.page end,
            func = function() stepPage(-1) end
        },
        nextPage = {
            cond = function(e, evs) return e == evs.release.page end,
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
            cond = function(e, evs) return e == evs.release.menu end,
            func = function()
                setState("displayMenu")
                setLock("displayMenu.exit")
            end
        },
        home = {
            cond = function(e, evs) return e == evs.longPress.menu end,
            func = function()
                setLock("display.menu")
                gotoPage(1)
            end
        },
        exit = {
            cond = function(e, evs) return e == evs.release.exit end,
            func = function() protocol.exitFunc() end
        }
    },
    editing = {
        decValue = {
            cond = function(e, evs) return e == evs.dial.left end,
            func = function() stepValue(-1) end
        },
        stepValue = {
            cond = function(e, evs) return e == evs.dial.right end,
            func = function() stepValue(1) end
        },
        exit = {
            cond = function(e, evs) return e == evs.release.enter or e == evs.release.menu or e == evs.release.exit end,
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
            cond = function(e, evs) return e == evs.release.exit or e == evs.release.menu end,
            func = function()
                setState("display")
            end
        }
    }
}
