local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local lain  = require("lain")
local markup = lain.util.markup

local GET_SPOTIFY_STATUS_CMD = os.getenv("HOME") .. '/.config/awesome/spotify_stat'
local GET_CURRENT_SONG_CMD = 'sp current-oneline'
local PATH_TO_ICONS = "/usr/share/icons/Numix"

spotify_widget = wibox.widget {
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
    },
    {
        id = 'current_song',
        widget = wibox.widget.textbox,
        font = 'liberation-sans 9'
    },
    layout  = wibox.layout.align.horizontal,
    set_image = function(self, path)
        self.icon.image = path
    end,
    set_text = function(self, path)
        self.current_song.markup = path
    end,
}

local update_widget_icon = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    if (stdout == 'RUNNING') then
        widget:set_image(PATH_TO_ICONS .. "/24/actions/player_play.svg")
    elseif (stdout == "CORKED") then
        widget:set_image(PATH_TO_ICONS .. "/24/actions/player_pause.svg")
    else
        widget:set_image(nil)
    end
end

local update_widget_text = function(widget, stdout, _, _, _)
    if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
        widget:set_text('')
        widget:set_visible(false)
    else
        widget:set_text("<span fgcolor='#474747' weight='bold'>" .. stdout .. "</span>")
        widget:set_visible(true)
    end
end

watch(GET_SPOTIFY_STATUS_CMD, 1, update_widget_icon, spotify_widget)
watch(GET_CURRENT_SONG_CMD, 1, update_widget_text, spotify_widget)

--[[
-- Adds mouse control to the widget:
--  - left click - play/pause
--  - scroll up - play next song
--  - scroll down - play previous song ]]
spotify_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn("sp play", false)      -- left click
    elseif (button == 4) then awful.spawn("sp next", false)  -- scroll up
    elseif (button == 5) then awful.spawn("sp prev", false)  -- scroll down
    end
    awful.spawn.easy_async(GET_SPOTIFY_STATUS_CMD, function(stdout, stderr, exitreason, exitcode)
        update_widget_icon(spotify_widget, stdout, stderr, exitreason, exitcode)
    end)
end)
