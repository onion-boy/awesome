local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local gfs = gears.filesystem
local beautiful = require("beautiful")

local util = require("util")
local dock = require("dock")
local watch = awful.widget.watch

local dashboard = {}

beautiful.init(gfs.get_configuration_dir() .. "theme.lua")

function stat_bar(from, color)
    return {
        watch(util.run(from), 1, function(w,s)
            w:set_value(tonumber(s))
        end, wibox.widget {
            widget = wibox.widget.progressbar,
            max_value = 100,
            value = 0,
            background_color = beautiful.system_widget_bg,
            color = color
        }),
        layout = wibox.container.rotate,
        direction = "east",
        forced_height = 100,
        forced_width = 25
    }
end

function stat_screen(title, content)
    return {
        layout = wibox.container.margin,
        margins = 35,
        {                        
            layout = wibox.container.background,
            bg = beautiful.system_widget_bg,
            shape = util.round(4),
            {
                layout = wibox.container.margin,
                margins = 20,
                {
                    layout = wibox.layout.fixed.vertical,
                    spacing = 20,
                    {
                        widget = wibox.widget.textbox,
                        font = beautiful.system_widget_font,
                        align = "center",
                        valign = "center",
                        markup = "<span color='#ffffff'>"..title.."</span>",
                    },
                    content
                }
            }
        }
    }
end

dashboard.right = awful.popup {
    widget = {
        layout = wibox.layout.fixed.vertical,
        stat_screen("resource monitor", {
            {
                {
                    spacing = 25,
                    stat_bar("ram", beautiful.ram_bg),
                    stat_bar("ram", beautiful.bg_urgent),
                    stat_bar("ram", beautiful.cpu_bg),
                    stat_bar("ram", beautiful.cpu_bg),
                    layout = wibox.layout.fixed.horizontal,
                    -- ADD STORAGE stat_bar("storage", beautiful.storage_bg),
                    -- ADD BATTERY stat_bar("battery", beautiful.battery_bg),
                    -- ADD TEMP stat_bar("temp", beautiful.temp_bg)
                },
                {
                    {
                        {
                            widget = wibox.widget.imagebox,
                            image = beautiful.ram_icon,
                            resize = true,
                            forced_height = 22,
                            forced_width = 22
                        },
                        {
                            widget = wibox.widget.imagebox,
                            image = beautiful.storage_icon,
                            resize = true,
                            forced_height = 22,
                            forced_width = 22
                        },
                        {
                            widget = wibox.widget.imagebox,
                            image = beautiful.battery_charging_icon,
                            resize = true,
                            forced_height = 22,
                            forced_width = 22
                        },
                        {
                            widget = wibox.widget.imagebox,
                            image = beautiful.temp_icon,
                            resize = true,
                            forced_height = 22,
                            forced_width = 22
                        },
                        layout = wibox.layout.fixed.horizontal,
                        spacing = 28
                    },
                    layout = wibox.container.margin,
                    left = 2
                },
                layout = wibox.layout.fixed.vertical,
                spacing = 5
            },
            layout = wibox.container.margin,
            left = 7.5
        }),
        forced_width = 300,
        forced_height = 280,
        spacing = -35
    },
    x = 1430,
    y = 185,
    visible = false,
    shape = util.round(12),
    screen = 1,
    bg = beautiful.widget_bg,
}

dashboard.center = awful.popup {
    widget = {
        layout = wibox.container.margin,
        margins = 35,
        forced_width = 875,
        forced_height = 710,
        {
            {
                {
                    {
                        {
                            widget = wibox.widget.textclock,
                            format = "<span color='#ffffff'>%H:%M</span>",
                            font = beautiful.big_clock_font
                        },
                        {
                            widget = wibox.widget.textclock,
                            format = "<span color='#ffffff'>%A, %B %d</span>",
                            font = beautiful.taglist_font
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    layout = wibox.container.margin,
                    margins = 35
                },
                layout = wibox.container.background,
                bg = beautiful.system_widget_bg,
                shape = util.round(4),
                forced_width = 300,
                forced_height = 200
            },
            {
                {
                    widget = wibox.widget.textbox,
                    font = beautiful.notification_title_font,
                    valign = "top",
                    markup = "<span color='#ffffff'>Notifications</span>"
                },
                layout = wibox.container.margin,
                left = 20,
                top = 10
            },
            layout = wibox.layout.fixed.horizontal,
        }
    },
    x = 520,
    y = 185,
    visible = false,
    shape = util.round(12),
    screen = 1,
    bg = beautiful.widget_bg
}

local song_name

local cover_w = wibox.widget.imagebox(gears.surface.load_uncached(beautiful.not_playing_icon), true)
local artist_w = wibox.widget.textbox("")

function audio_button(name)
    local btn = wibox.widget.imagebox(gears.surface.load_uncached(beautiful[name.."_icon"]), true) 
    local old_icon = name

    return {
        buttons = gears.table.join(
            awful.button({ }, 1, function (c)
                awful.spawn.with_shell(util.run("spotify/"..name))
            end)
        ),
        widget = util.cursor(btn, "hand2")
    }
end

local playbutton = audio_button("play")

dashboard.top_left = awful.popup {
    widget = {
        widget = wibox.layout.margin,
        margins = 35,
        {
            {
                widget = cover_w,
                forced_height = 230,
                forced_width = 230,
            },
            {
                {
                    widget = artist_w,
                    align = "center",
                    ellipsize = "end",
                    forced_height = 25,
                    font = beautiful.song_artist_font,
                },
                watch(util.run("spotify/status"), 1, function(w,s,e)
                    local i = 0
                    local status = "Stopped"
                    local title = ""

                    for s_status,s_title in s:gmatch("status|([^\n]+)\ntitle|([^\n]+)") do
                        status = s_status
                        title = s_title
                    end

                    if song_name ~= title and status ~= "Stopped" then
                        w:set_markup("<span color='#ffffff'>"..title.."</span>")
                        awful.spawn.easy_async(util.run("spotify/cover"), function()
                            cover_w:set_image(gears.surface.load_uncached(beautiful.album_cover))
                        end)
                        awful.spawn.easy_async(util.run("spotify/artist"), function(out)
                            artist_w:set_markup("<span color='#ffffff'>"..out.."</span>")
                        end)
                        song_name = title
                    end
                    if status == "Stopped" then
                        w:set_markup("<span color='#ffffff'>not playing</span>")
                        cover_w:set_image(gears.surface.load_uncached(beautiful.not_playing_icon))
                        artist_w:set_markup("")
                        song_name = ""
                    end

                    if status == "Paused" then
                        playbutton.widget.image = gears.surface.load_uncached(beautiful.play_icon)
                    elseif status == "Playing" then
                        playbutton.widget.image = gears.surface.load_uncached(beautiful.pause_icon)
                    end
                end, wibox.widget {
                    widget = wibox.widget.textbox,
                    markup = "<span color='#ffffff'>not playing</span>",
                    align = "center",
                    ellipsize = "middle",
                    forced_height = 25,
                    font = beautiful.system_widget_font
                }),
                layout = wibox.layout.fixed.vertical,
                spacing = -3,
            },
            {
                {
                    {
                        audio_button("prev"),
                        playbutton,
                        audio_button("next"),
                        layout = wibox.layout.flex.horizontal,
                        spacing = 23
                    },
                    layout = wibox.container.margin,
                    top = 10,
                    left = 2,
                    right = -15
                },
                layout = wibox.container.margin,
                top = -10,
                left = 15,
                right = 15,
                bottom = -5
            },
            layout = wibox.layout.fixed.vertical,
            spacing = 15,
        },
        forced_width = 300,
        forced_height = 410,
    },
    x = 185,
    y = 185,
    visible = false,
    shape = util.round(12),
    screen = 1,
    bg = beautiful.widget_bg,
}

dashboard.bottom_left = awful.popup {
    widget = stat_screen("cpu usage", {
        widget = watch(util.run("cpu"), 3, function(w, s)
            w:add_value(tonumber(s), 1)
        end, wibox.widget {
            max_value = 100,
            widget = wibox.widget.graph,
            forced_width = 180,
            forced_height = 90,
            step_spacing = 2,
            step_width = 18,
            background_color = beautiful.system_widget_bg,
            color = beautiful.cpu_bg
        }),
        forced_width = 190,
        forced_height = 113
    }),
    x = 185,
    y = 630,
    visible = false,
    shape = util.round(12),
    screen = 1,
    bg = beautiful.widget_bg,
}

return dashboard