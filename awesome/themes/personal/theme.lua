
--[[
                                 
     Powerarrow Awesome WM theme 
     github.com/copycat-killer   
                                 
--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local collision = require("collision")
local os, math, string, next = os, math, string, next

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/personal"
theme.wallpaper                                 = os.getenv("HOME") .. "/Pictures/6.png"
theme.font                                      = "liberation-sans 9"
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#222222"
theme.bg_focus                                  = "#1E2320"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#00CCFF"--"#00CCFF"
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
theme.widget_ac                                 = theme.dir .. "/icons/ac.png"
theme.widget_battery                            = theme.dir .. "/icons/battery.png"
theme.widget_battery_low                        = theme.dir .. "/icons/battery_low.png"
theme.widget_battery_empty                      = theme.dir .. "/icons/battery_empty.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"
theme.widget_temp                               = theme.dir .. "/icons/temp.png"
theme.widget_net                                = theme.dir .. "/icons/net.png"
theme.widget_hdd                                = theme.dir .. "/icons/hdd.png"
theme.widget_music                              = theme.dir .. "/icons/note.png"
theme.widget_music_on                           = theme.dir .. "/icons/note_on.png"
theme.widget_music_pause                        = theme.dir .. "/icons/pause.png"
theme.widget_music_stop                         = theme.dir .. "/icons/stop.png"
theme.widget_vol                                = theme.dir .. "/icons/vol.png"
theme.widget_vol_low                            = theme.dir .. "/icons/vol_low.png"
theme.widget_vol_no                             = theme.dir .. "/icons/vol_no.png"
theme.widget_vol_mute                           = theme.dir .. "/icons/vol_mute.png"
theme.widget_mail                               = theme.dir .. "/icons/mail.png"
theme.widget_mail_on                            = theme.dir .. "/icons/mail_on.png"
theme.widget_task                               = theme.dir .. "/icons/task.png"
theme.widget_scissors                           = theme.dir .. "/icons/scissors.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = 3
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
theme.icon_theme                                = "Luv"

local markup = lain.util.markup
local separators = lain.util.separators

-- Clock
local clock = wibox.widget.textclock(" %a %b %d  %l:%M %p", 60)

-- Binary clock
--local binclock = require("themes.powerarrow.binclock"){
--    height = 16,
--    show_seconds = true,
--    color_active = theme.fg_normal,
--    color_inactive = theme.bg_focus
--}

-- Calendar
--theme.cal = lain.widget.calendar({
    --cal = "cal --color=always",
  --  attach_to = { binclock.widget },
   -- notification_preset = {
     --   font = "xos4 Terminus 10",
       -- fg   = theme.fg_normal,
       -- bg   = theme.bg_normal
   -- }
--})

-- Taskwarrior
local task = wibox.widget.imagebox(theme.widget_task)
lain.widget.contrib.task.attach(task, {
    -- do not colorize output
    show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'"
})
task:buttons(awful.util.table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))

-- Scissors (xsel copy and paste)
local scissors = wibox.widget.imagebox(theme.widget_scissors)
scissors:buttons(awful.util.table.join(awful.button({}, 1, function() awful.spawn("xsel | xsel -i -b") end)))

-- ALSA volume
theme.volume = lain.widget.alsabar({
    togglechannel = "IEC958,3",
    notification_preset = { font = "xos4 Terminus 10", fg = theme.fg_normal },
    height = 0.5,
})

--[[
-- MPD
local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
local mpdicon = wibox.widget.imagebox(theme.widget_music)
mpdicon:buttons(awful.util.table.join(
    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
    awful.button({ }, 1, function ()
        awful.spawn.with_shell("mpc prev")
        theme.mpd.update()
    end),
    awful.button({ }, 2, function ()
        awful.spawn.with_shell("mpc toggle")
        theme.mpd.update()
    end),
    awful.button({ }, 3, function ()
        awful.spawn.with_shell("mpc next")
        theme.mpd.update()
    end)))
theme.mpd = lain.widget.mpd({
    settings = function()
        if mpd_now.state == "play" then
            artist = " " .. mpd_now.artist .. " "
            title  = mpd_now.title  .. " "
            mpdicon:set_image(theme.widget_music_on)
            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
        elseif mpd_now.state == "pause" then
            widget:set_markup(markup.font(theme.font, " mpd paused "))
            mpdicon:set_image(theme.widget_music_pause)
        else
            widget:set_text("")
            mpdicon:set_image(theme.widget_music)
        end
    end
})
--]]

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

--local music = lain.widget.music({
--    settings = function()
--        widget:set_markup(markup.font(theme.font, " " .. music_now.status .. " "))
--    end
--})

-- / fs
local fsicon = wibox.widget.imagebox(theme.widget_hdd)
theme.fs = lain.widget.fs({
    options  = "--exclude-type=tmpfs",
    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "xos4 Terminus 10" },
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. fs_now.available_gb .. "GB "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
--local batcolor = "#8DAA9A"
local bat = lain.widget.bat({
    ac = "AC",
    settings = function()
        if bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " ︇︇" .. bat_now.perc .. "% "))
                baticon:set_image(theme.widget_ac)
                return
            elseif bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
               -- batcolor = "#FF0000"
            elseif bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
                --batcolor = "#FF4500"
            else
                baticon:set_image(theme.widget_battery)
                --batcolor = "#F87531"
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            baticon:set_image(theme.widget_ac)
        end
    end
})


-- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE"," " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

-- Separators
local arrow = separators.arrow_left

function theme.powerline_rl(cr, width, height)
    local arrow_depth, offset = height/2, 0

    -- Avoid going out of the (potential) clip area
    if arrow_depth < 0 then
        width  =  width + 2*arrow_depth
        offset = -arrow_depth
    end

    cr:move_to(offset + arrow_depth         , 0        )
    cr:line_to(offset + width               , 0        )
    cr:line_to(offset + width - arrow_depth , height/2 )
    cr:line_to(offset + width               , height   )
    cr:line_to(offset + arrow_depth         , height   )
    cr:line_to(offset                       , height/2 )

    cr:close_path()
end

local function pl(widget, bgcolor, padding)
    return wibox.container.background(wibox.container.margin(widget, 16, 16), bgcolor, theme.powerline_rl)
end

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
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)
    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 16, bg = "alpha", fg = theme.fg_normal })
    s.mybottomwibox = awful.wibar({ position = "bottom", screen = s, height = 16, bg = "alpha", fg = theme.fg_normal })
    -- Add widgets to the wibox 
    s.mybottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        nil,
        nil,
        s.mytasklist,
    }
--{{ This will identify if a selected tag is empty, and if so, will make the bottom wibox
--   disappear until the tag becomes nonempty
function identify_empty(my_tag)
    if next(my_tag:clients()) == nil then
        my_tag.empty = true
    else
        my_tag.empty = false
    end
end

tag.connect_signal("property::selected", function(tag)
    identify_empty(tag)
    if tag.empty then
        s.mybottomwibox.visible = false
    elseif not tag.empty then
        s.mybottomwibox.visible = true
    end
end)

client.connect_signal("tagged", function(my_client)
    for _,tag in pairs(my_client:tags()) do
        identify_empty(tag)
        if tag.empty then
            s.mybottomwibox.visible = false
        elseif not tag.empty then
            s.mybottomwibox.visible = true
        end
    end
end)
--}}

    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            --spr,
            s.mytaglist,
            wibox.container.margin(s.mypromptbox, 10, 10)
            --spr,
        },
            nil, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            arrow("alpha", "alpha"),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, theme.volume.bar, layout = wibox.layout.align.horizontal }, 3, 2, 5, 5), "alpha"),
            arrow("alpha", "#777E76"),
            wibox.container.background(wibox.container.margin(wibox.widget { memicon, mem.widget, layout = wibox.layout.align.horizontal }, 2, 3), "#777E76"),
            arrow("#777E76", "#CB755B"),
            wibox.container.background(wibox.container.margin(wibox.widget { fsicon, theme.fs.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#CB755B"),
            arrow("#CB755B", "#8DAA9A"),
            wibox.container.background(wibox.container.margin(wibox.widget { baticon, bat.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#8DAA9A"),
            arrow("#8DAA9A", "#C0C0A2"),
            wibox.container.background(wibox.container.margin(wibox.widget { nil, neticon, net.widget, layout = wibox.layout.align.horizontal }, 3, 3), "#C0C0A2"),
            arrow("#C0C0A2","#777E76"),
            wibox.container.background(wibox.container.margin(clock, 4, 10), "#777E76"),
            arrow("#777E76", "#222211"),
            wibox.container.background(wibox.container.margin(s.mylayoutbox,2,2), "#222211"),
        },
    }
end

return theme
