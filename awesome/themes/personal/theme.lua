
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local collision = require("collision")
local os, math, string, next = os, math, string, next
local spotify_display = require("spotify")
--local naughty = require("naughty")

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/personal"
theme.wallpaper                                 = theme.dir .. "/desktop/wall.png"
theme.font                                      = "Lato semibold 10"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#222222"
theme.bg_focus                                  = "#1E2320"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#00CCFF"
theme.taglist_bg_focus                          = "#22222200"
theme.tasklist_bg_normal                        = "#22222200"
theme.tasklist_bg_focus                         = "#22222200"
theme.tasklist_fg_focus                         = "#00CCFF"
theme.border_width                              = 2
theme.border_normal                             = "#3F3F3F"
theme.border_focus                              = "#D3D3D3"
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_height                               = 25
theme.menu_width                                = 140
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"
theme.taglist_squares_sel                       = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                     = theme.dir .. "/icons/square_unsel.png"
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music_play                         = theme.dir .. "/icons/play-button.svg"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.svg"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 15
theme.titlebar_close_button_focus               = theme.dir .. "/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.dir .. "/icons/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.dir .. "/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.dir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.dir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.dir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.dir .. "/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.dir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.dir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.dir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.dir .. "/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.dir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.dir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.dir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.dir .. "/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.dir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.dir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.dir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.icon_theme                                = "Numix"
theme.systray_icon_spacing                      = 6
theme.bg_systray                                = "#474747"

local markup = lain.util.markup
local separators = lain.util.separators

-- ALSA volume
theme.volume = lain.widget.alsabar({
    togglechannel = "IEC958,3",
    notification_preset = { font = "xos4 Terminus 10", fg = theme.fg_normal },
    height = 0.5,
})

-- Spotify
local spotifyicon = wibox.widget.imagebox()
local spotify = spotify_display({
    timeout = 0.6,
    settings = function()
        if metadata.status ~= "" and metadata.title ~= "" and metadata.artist ~= "" then
            display = "<span weight='heavy' foreground='#474747' font='" .. theme.font .. "'>" .. metadata.title .. " by " .. metadata.artist .. "</span>"
            widget:set_markup(display)
            if metadata.status == 'Playing' then
                spotifyicon.image = theme.widget_music_play
            elseif metadata.status == 'Paused' then
                spotifyicon.image = theme.widget_music_pause
            end
        else 
            widget:set_text("     ")
            spotifyicon.image = nil
        end
    end})

-- Clock
local clock = wibox.widget.textclock("<span font='" .. theme.font .. "'>%a %b %d  %l:%M %p </span>", 59)

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    timeout = 599,
    settings = function()
        widget:set_markup("<span font='" .. theme.font ..  "'> " .. mem_now.used .. "MB " .. "</span>")
    end
})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    timeout = 599,
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    settings = function()
        widget:set_markup("<span font='" .. theme.font .. "'> " .. fs_now.available_gb .. "GB " .. "</span>")
    end
})

-- Separators
local arrow = separators.arrow_left

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, {font = theme.font})

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
    
    -- Create the wiboxes
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 16, bg = "alpha", fg = theme.fg_normal })
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = 16, bg = "alpha", fg = theme.fg_normal })
    
    -- Create the systray widget
    local systray = wibox.widget.systray()
    
    -- Add widgets to the wibox 
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        nil,
        nil,
        s.mytasklist,
    }

    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            wibox.container.margin(s.mypromptbox, 10, 10)
        },
            nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            arrow("alpha","#cccccc"),
            wibox.container.background(wibox.container.margin(wibox.widget { wibox.container.margin(spotifyicon,0,6,2,1), spotify.widget, layout = wibox.layout.align.horizontal },30,30,0,1),"#cccccc"),
            arrow("#cccccc", "#959595"),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 2, 3,0,1), "#959595"),
            arrow("#959595", "#6e6e6e"),
            wibox.container.background(wibox.container.margin(wibox.widget { fsicon, theme.fs.widget, layout = wibox.layout.align.horizontal }, 3, 3,0,1), "#6e6e6e"),
            arrow("#6e6e6e",theme.bg_systray),
            wibox.container.background(wibox.container.margin(systray,6,2), theme.bg_systray),
            wibox.container.background(wibox.container.margin(clock, 8, 10,0,1), theme.bg_systray),
            arrow(theme.bg_systray, "#202020"),
            wibox.container.background(wibox.container.margin(s.mylayoutbox,2,2), "#202020"),
        },
    }
end

return theme
