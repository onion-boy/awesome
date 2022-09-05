local gears = require("gears")
local awful = require("awful")

local gfs = gears.filesystem

local util = {}

function util.round(amount)
    return function (cr,w,h)
        gears.shape.rounded_rect(cr,w,h,amount)
    end
end

function util.run(from)
    return 'bash '..gfs.get_configuration_dir()..'scripts/'..from..'.sh'
end

function util.cursor(widget, cursor)
    local old_cursor, old_wibox
    widget:connect_signal("mouse::enter", function()
        -- Hm, no idea how to get the wibox from this signal's arguments...
        local w = mouse.current_wibox
        old_cursor, old_wibox = w.cursor, w
        w.cursor = "hand2"
    end)
    
    widget:connect_signal("mouse::leave", function()
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    return widget
end

function util.tooltip(widget, text)
    local tooltip = awful.tooltip {
        mode = "outside",
        preferred_positions = { "top" },
        preferred_alignments = { "middle" }
    }
    tooltip:add_to_object(widget)
    widget:connect_signal("mouse::enter", function()
        tooltip.text = text
    end)
end

return util