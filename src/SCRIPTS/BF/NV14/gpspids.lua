return {
   read           = 136, -- MSP_GPS_RESCUE_PIDS
   write          = 226, -- MSP_SET_GPS_RESCUE_PIDS
   title          = "GPS Rescue / PIDs",
   reboot         = false,
   eepromWrite    = true,
   minBytes       = 14,
   requiredVersion = 1.041,
   text = {
      { t = "P",        x = 100,  y =  48, to = MIDSIZE },
      { t = "I",        x = 180,  y =  48, to = MIDSIZE },
      { t = "D",        x = 260,  y =  48, to = MIDSIZE },
      { t = "Throttle", x =  10,  y = 100 },
      { t = "Velocity", x =  10,  y = 150 },
      { t = "Yaw"     , x =  10,  y = 200 },
   },
   fields = {
      -- P
      { x = 100, y = 100, min = 0, max = 200, vals = { 1, 3  }, to = MIDSIZE },
      { x = 100, y = 150, min = 0, max = 200, vals = { 7, 8  }, to = MIDSIZE },
      { x = 100, y = 200, min = 0, max = 500, vals = {13,14  }, to = MIDSIZE },
      -- I
      { x = 180, y = 100, min = 0, max = 200, vals = { 3, 4  }, to = MIDSIZE },
      { x = 180, y = 150, min = 0, max = 200, vals = { 9,10  }, to = MIDSIZE },
      -- D
      { x = 260, y = 100, min = 0, max = 200, vals = { 5, 6  }, to = MIDSIZE },
      { x = 260, y = 150, min = 0, max = 200, vals = { 11,12 }, to = MIDSIZE },
   },
}
