PageFiles =
{
--    "exmpl1.lua",
    "pids1.lua",
    "pids2.lua",
    "rates.lua",
    "pid_advanced.lua",
    "filters.lua",
    "pwm.lua",
    "vtx.lua",
    "rescue.lua",
    "gpspids.lua",
}

MenuBox = { x=15, y=12, w=100, x_offset=36, h_line=8, h_offset=3 }
SaveBox = { x=15, y=12, w=100, x_offset=4,  h=30, h_offset=5 }
NoTelem = { 32, 55, "No Telemetry!", BLINK }

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

---- radio specific overrides
-- X-Lite
if string.match(radio.name, "^xlite") then
    ctrlSchema.display.prevPage.cond = function(e, evs) return e == evs.press.pageUp end
    ctrlSchema.display.nextPage.cond = function(e, evs) return e == evs.release.menu end
    ctrlSchema.display.menu.cond = function(e, evs) return e == 32 end
    ctrlSchema.display.home.cond = function(e, evs) return e == 128 end
    ctrlSchema.displayMenu.exit.cond = function(e, evs) return e == 32 end
end
