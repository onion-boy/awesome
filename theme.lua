---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local assets = gfs.get_configuration_dir().."/assets/"
local icons = assets.."/icons/"
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "space mono bold 9"
theme.tasklist_font = "red hat display bold 9"
theme.taglist_font  = "cascadia code 10"
theme.system_widget_font = "red hat display bold 12"
theme.song_artist_font = "red hat display 10"
theme.notification_title_font = "cascadia code bold 17"
theme.big_clock_font = "space mono 25"
theme.popup_clock_font = "red hat display bold 27"

theme.dock_firefox_icon = "/usr/share/icons/hicolor/48x48/apps/firefox-developer-edition.png"
theme.dock_spotify_icon = "/usr/share/icons/hicolor/48x48/apps/spotify.png"
theme.dock_xterm_icon = "/usr/share/icons/hicolor/48x48/apps/org.xfce.terminalemulator.png"
theme.dock_thunderbird_icon = "/usr/share/icons/hicolor/48x48/apps/thunderbird.png"

theme.wallpaper     = assets.."bg.jpg"
theme.album_cover   = "/tmp/spotify_current.jpg"

theme.cpu_bg = "#3B8EA5"
theme.ram_bg = "#81E979"
theme.widget_bg = "#2b373daa"
theme.system_widget_bg = "#262626"
theme.widget_bg_over = "#2b373d"
theme.popup_bg = "#2b373dcd"
theme.popup_menu = "#566269"
theme.prompt_bg = "#667080"

theme.bg_normal     = "#FFFFFF"
theme.bg_focus      = "#FFFFFF"
theme.bg_urgent     = "#D33643"
theme.bg_minimize   = "#FFFFFF"
theme.bg_systray    = "#FFFFFF"

theme.fg_normal     = "#000000"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#000000"

theme.hotkeys_modifiers_fg = "#000000"
theme.client_indicator = icons.."client.png"

theme.useless_gap   = dpi(2)
theme.border_width  = dpi(0)
theme.border_normal = "#000000"
theme.border_focus  = "#94AE89"
theme.border_marked = "#94AE89"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- theme.taglist_bg_focus = theme.widget_bg
theme.taglist_bg = "#2b373ddd"

theme.wifi_icon = icons.."wifi.png"
theme.wifi_off_icon = icons.."wifi_off.png"
theme.bluetooth_icon = icons.."bluetooth.png"
theme.airplane_icon = icons.."airplane.png"
theme.volume_up_icon = icons.."volume_up.png"
theme.volume_down_icon = icons.."volume_down.png"
theme.volume_mute_icon = icons.."volume_mute.png"
theme.brightness_icon = icons.."brightness.png"
theme.not_playing_icon = icons.."note.png"
theme.pause_icon = icons.."pause.png"
theme.play_icon = icons.."play.png"
theme.prev_icon = icons.."back.png"
theme.next_icon = icons.."ff.png"

theme.ram_icon = icons.."ram.png"
theme.storage_icon = icons.."storage.png"
theme.battery_charging_icon = icons.."battery_charging.png"
theme.temp_icon = icons.."temp.png"

theme.titlebar_button_hovered = "#445057"

theme.titlebar_bg_focus = "#2b373d"
theme.titlebar_bg_normal = "#2b373d"
theme.titlebar_fg = "#FFFFFF"

theme.tasklist_bg_focus = "#e3e3e3"
theme.tasklist_bg_normal = "#FFFFFF"
theme.tasklist_disable_icon = true

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(18)
theme.menu_width  = dpi(200)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = icons.."close.png"
theme.titlebar_close_button_focus  = icons.."close.png"

theme.titlebar_minimize_button_normal = icons.."hide.png"
theme.titlebar_minimize_button_focus  = icons.."hide.png"

theme.titlebar_ontop_button_normal_inactive = icons.."layers.png"
theme.titlebar_ontop_button_focus_inactive  = icons.."layers.png"
theme.titlebar_ontop_button_normal_active = icons.."layered.png"
theme.titlebar_ontop_button_focus_active  = icons.."layered.png"

theme.titlebar_sticky_button_normal_inactive = icons.."pin.png"
theme.titlebar_sticky_button_focus_inactive  = icons.."pin.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = icons.."max.png"
theme.titlebar_maximized_button_focus_inactive  = icons.."max.png"
theme.titlebar_maximized_button_normal_active = icons.."min.png"
theme.titlebar_maximized_button_focus_active  = icons.."min.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairh.png"
theme.layout_fairv = themes_path.."default/layouts/fairv.png"
theme.layout_floating  = themes_path.."default/layouts/floating.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifier.png"
theme.layout_max = themes_path.."default/layouts/max.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreen.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottom.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleft.png"
theme.layout_tile = themes_path.."default/layouts/tile.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletop.png"
theme.layout_spiral  = themes_path.."default/layouts/spiral.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindle.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernw.png"
theme.layout_cornerne = themes_path.."default/layouts/cornerne.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersw.png"
theme.layout_cornerse = themes_path.."default/layouts/cornerse.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80