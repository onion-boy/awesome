local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local gfs = gears.filesystem
local beautiful = require("beautiful")

local util = require("util")

local dock = {}

beautiful.init(gfs.get_configuration_dir() .. "theme.lua")

function textclock(font, format) 
    return {
        widget = awful.widget.textclock,
        format = "<span color='#ffffff'>"..(format or "%H:%M").."</span>", 
        refresh = 1,
        align = "left",
        font = beautiful[font],
    }
end

function dock_util_icon(name, size)
    local icon_button = wibox.widget.imagebox(beautiful[name.."_icon"], true)
    icon_button.forced_width = size or 18
    icon_button.forced_height = size or 18
    return icon_button
end

function app_icon(name, screen)
    local icon = wibox.widget.imagebox(beautiful["dock_"..name.."_icon"], true)
    local clients = screen.all_clients

    util.tooltip(icon, tooltip or name)
    icon.forced_width = 32
    icon.forced_height = 32
    
    for _,c in ipairs(clients) do
        
    end

    -- icon:buttons(gears.table.join(
    --     awful.button({ }, 1)
    -- ))

    return util.cursor(icon, "hand2")
end

function top(widget, margin) 
    return {
        layout = wibox.container.margin,
        top = margin,
        widget
    }
end

function alter_for_dashboard(name)
    if name ~= "dashboard" then
        return "screen "..name
    end 
    return name
end

function popup_menu(name)
    return {
        layout = wibox.container.background,
        bg = beautiful.popup_menu,
        shape = gears.shape.circle,
        {
            layout = wibox.container.margin,
            margins = 20,
            {
                widget = util.cursor(dock_util_icon(name, 22), "hand2")
            }
        }
    }
end

function popup_slider(name, margin)
    local slider = wibox.widget {
        widget = wibox.widget.slider,
        bar_shape = util.round(2),
        bar_height = 4,
        bar_color = "#FFFFFF",
        handle_color = "#FFFFFF",
        handle_shape = gears.shape.circle,
        value = 0,
        forced_width = 280,
        forced_height = 25
    }
    
    local slider_indicator = wibox.widget {
        widget = wibox.widget.imagebox,
        image = beautiful[name.."_icon"],
        resize = true,
        forced_width = 26,
        forced_height = 26
    }
    return {
        layout = wibox.layout.fixed.horizontal,
        spacing = 8,
        slider_indicator,
        top(slider, margin or -1)
    }
end

local volume_slider = popup_slider("volume_up")
local brightness_slider = popup_slider("brightness", -2)

dock.popup = awful.popup {
    widget = {
        layout = wibox.container.margin,
        forced_width = 400,
        forced_height = 325,
        margins = 25,
        {
            layout = wibox.layout.fixed.vertical,
            spacing = 15,
            {
                layout = wibox.layout.fixed.vertical,
                spacing = -1,
                textclock("popup_clock_font"),
                textclock("system_widget_font", "%A, %B %d")
            },
            {
                layout = wibox.container.margin,
                margins = 20,
                {
                    layout = wibox.layout.align.horizontal,
                    expand = "none",
                    popup_menu("wifi"),
                    popup_menu("bluetooth"),
                    popup_menu("airplane")
                }
            },
            {
                layout = wibox.container.margin,
                left = 17,
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = 12,
                    volume_slider,
                    brightness_slider
                }
            }
        }
    },
    x = 1512,
    y= 700,
    bg = beautiful.popup_bg,
    shape = util.round(8),
    visible = false,
    ontop = true,
}

dock.bottom = function (s)
    local wibar = awful.wibar { 
        position = "bottom", 
        screen = s, 
        height = 50, 
        bg = "#00000000"
    }

    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 3, function(t) awful.tag.viewprev(t.screen) end)
    )

    local tag_label = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.selected,
        buttons = taglist_buttons,
        widget_template = {
            forced_width = 200,
            forced_height = 36,
            widget = wibox.widget.textbox,
            font = beautiful.taglist_font,
            id = "index",
            align = "left",
            create_callback = function(self, c3, index, objects)
                self.markup = "<span color='#ffffff'>"..alter_for_dashboard(c3.name).."</span>"
            end,
            update_callback = function(self, c3, index, objects)
                self.markup = "<span color='#ffffff'>"..alter_for_dashboard(c3.name).."</span>"
            end,
        }
    }

    local dock_icons = {
        firefoxdeveloperedition = "firefox",
        spotify = "spotify",
        thunderbird = "thunderbird",
        xterm = "xterm"
    }

    local iconset = {
        layout = wibox.layout.fixed.horizontal,
        spacing = 12
    }

    local indicatorset = {
        layout = wibox.layout.fixed.horizontal,
        spacing = 12
    }

    local wifi_indicator = dock_util_icon("wifi_off")
    local volume_indicator = dock_util_icon("volume_up")
    local airplane_indicator = dock_util_icon("airplane")
    local bluetooth_indicator = dock_util_icon("bluetooth")

    for class, app_name in pairs(dock_icons) do
        local indicator_list = {}
        for i=1,3 do
            table.insert(indicator_list, {
                widget = wibox.widget.imagebox,
                image = beautiful.client_indicator,
                forced_width = 8,
                forced_height = 3,
                resize = true,
                visible = false
            })
        end
        table.insert(iconset, app_icon(app_name, s))
        table.insert(indicatorset, {
            layout = wibox.layout.align.horizontal,
            expand = "outside",
            forced_width = 32,
            forced_height = 3,
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 2,
                table.unpack(indicator_list)
            },
            nil
        })
    end

    wibar : setup {
        layout = wibox.container.background,
        bg = beautiful.widget_bg,
        forced_width = 1920,
        {
            widget = wibox.container.margin, 
            left = 19,
            top = 8,
            right = 8,
            bottom = 8,
            {
                layout = wibox.layout.align.horizontal,
                expand = "outside",
                util.cursor(tag_label, "hand2"),
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = 8,
                    iconset,
                    {
                        layout = wibox.container.margin,
                        left = 1,
                        indicatorset
                    }
                },
                {
                    layout = wibox.layout.align.horizontal,
                    nil,
                    nil,
                    {
                        layout = wibox.container.background,
                        bg = beautiful.widget_bg_over,
                        shape = util.round(4),
                        {
                            layout = wibox.container.margin,
                            left = 11,
                            right = 11,
                            {
                                layout = wibox.layout.fixed.horizontal,
                                spacing = 8,
                                top({
                                    layout = wibox.layout.fixed.horizontal,
                                    spacing = 4,
                                    wifi_indicator,
                                    dock_util_icon("brightness"),
                                    volume_indicator,
                                    -- bluetooth_indicator,
                                    -- airplane_indicator,
                                }, 8),
                                textclock("taglist_font")
                            },
                            buttons = gears.table.join(
                                awful.button({ }, 1, function()
                                    dock.popup.visible = not dock.popup.visible
                                end)
                            )
                        }
                    }
                }
            }
        },
    }
    
    return wibar
end

return dock