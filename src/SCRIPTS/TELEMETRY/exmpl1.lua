local function run(event)
    local rssi, alarm_low, alarm_crit = getRSSI()

    lcd.clear()

    -- throttle range
    lcd.drawText(3, 5, "THR", SMLSIZE)
    lcd.drawText(lcd.getLastPos()+1, 5, "RNG", SMLSIZE)
    lcd.drawNumber(lcd.getLastPos()+2, 5, getValue("gvar9") > 0 and getValue("gvar9") or 100)
    lcd.drawText(lcd.getLastPos(), 5, "%", SMLSIZE)

    -- armed
    if getValue("ls4") > 0 then
        lcd.drawText(60, 4, "ARMED", BLINK)
    end

    -- timer one
    lcd.drawTimer(LCD_W-35, 2, getValue("timer1"), MIDSIZE)

    -- tx battery voltage
    local format = SMLSIZE
    if getValue("tx-voltage") <= 0 then
        format = format+BLINK
    end
    lcd.drawText(3, 17, "BAT  ", format)
    lcd.drawNumber(28, 17, getValue("tx-voltage")*100, PREC2+format)
    lcd.drawText(lcd.getLastPos(), 17, "V", format)
    local settings = getGeneralSettings()
    local percent =  math.floor(((getValue("tx-voltage")-settings.battMin) * 100 / (settings.battMax-settings.battMin)) + 0.5)
    if percent <= 0 then percent = 0 end
    lcd.drawGauge(3, 25, LCD_W-10 , 3, percent, 100)

    -- VFAS current sensor
    format = SMLSIZE
    if getValue("VFAS") <= 0 then
        format = format+BLINK
    end
    lcd.drawText(3, 33, "VFAS  ", format)
    lcd.drawNumber(30, 33, getValue("VFAS")*100, PREC2+format)
    lcd.drawText(lcd.getLastPos(), 33, "V", format)
    local settings = getGeneralSettings()
    local percent = (getValue("VFAS")-settings.battMin) * 100 / (settings.battMax-settings.battMin)
    if percent <= 0 then percent = 0 end
    lcd.drawGauge(3, 40, LCD_W-10, 3, percent, 100)

    -- RSSI sensor
    format = SMLSIZE
    if rssi <= alarm_crit then
        format = format+BLINK
    end
    lcd.drawText(3, 48, "RSSI  ", format)
    lcd.drawNumber(lcd.getLastPos(), 48, rssi, format)
    lcd.drawText(lcd.getLastPos(), 48, "dB", format)
    lcd.drawGauge(3, 55, LCD_W-10, 3, rssi, 100)
end

return { run=run }
