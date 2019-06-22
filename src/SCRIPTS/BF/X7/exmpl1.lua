
local function run(event)
    -- Note: ui-functions like drawScreenTitle('your title') are also available here

    -- throttle range
    lcd.drawText(5, 5, "THR RNG ", SMLSIZE)
    lcd.drawNumber(lcd.getLastPos(), 5, getValue("gvar9") > 0 and getValue("gvar9") or 100, SMLSIZE)
    lcd.drawText(lcd.getLastPos(), 5, "%", SMLSIZE)

    -- armed
    if getValue("ls4") > 0 then
        lcd.drawText(60, 5, "ARMED", BLINK)
    end

    -- timer one
    lcd.drawTimer(94, 3, getValue("timer1"), MIDSIZE)

    -- tx battery voltage
    local format = SMLSIZE
    if getValue("tx-voltage") <= 0 then
        format = format+BLINK
    end
    lcd.drawText(5, 18, "BAT  ", format)
    lcd.drawNumber(30, 18, getValue("tx-voltage")*100, PREC2+format)
    lcd.drawText(lcd.getLastPos(), 18, "V", format)
    local settings = getGeneralSettings()
    local percent = (getValue("tx-voltage")-settings.battMin) * 100 / (settings.battMax-settings.battMin)
    if percent <= 0 then percent = 0 end
    lcd.drawGauge(5, 25, 118, 3, percent, 100)

    -- VFAS current sensor
    format = SMLSIZE
    if getValue("vfas") <= 0 then
        format = format+BLINK
    end
    lcd.drawText(5, 33, "VFAS  ", format)
    lcd.drawNumber(30, 33, getValue("vfas")*100, PREC2+format)
    lcd.drawText(lcd.getLastPos(), 33, "V", format)
    local settings = getGeneralSettings()
    local percent = (getValue("vfas")-settings.battMin) * 100 / (settings.battMax-settings.battMin)
    if percent <= 0 then percent = 0 end
    lcd.drawGauge(5, 40, 118, 3, percent, 100)

    -- RSSI sensor
    format = SMLSIZE
    if protocol.rssi() == 0 then
        format = format+BLINK
    end
    lcd.drawText(5, 48, "RSSI  ", format)
    lcd.drawNumber(lcd.getLastPos(), 48, protocol.rssi(), format)
    lcd.drawText(lcd.getLastPos(), 48, "dB", format)
    lcd.drawGauge(5, 55, 118, 3, protocol.rssi(), 100)
end

return { run = run }
