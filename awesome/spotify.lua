local awful = require("awful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local lain  = require("lain")
local helpers = require("lain.helpers")
local newtimer = require("lain.helpers").newtimer
local markup = lain.util.markup
local string = string
local naughty = require("naughty")

--local GET_SPOTIFY_STATUS_CMD = os.getenv("HOME") .. '/.config/awesome/spotify_stat'
--local GET_CURRENT_SONG_CMD = 'sp current-oneline'
--local PATH_TO_ICONS = os.getenv("HOME") .. "/.config/awesome/themes/powerarrow/icons"

local function construct(args)
    local spotify  = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 3
    local settings = args.settings or function() end
    
    metadata = {
        status = "N/A",
        title  = "N/A",
        artist = "N/A",
        album  = "N/A",
    }
    
    function spotify.update()
        local get_status = "playerctl status"
        local get_title  = "playerctl metadata xesam:title"
        local get_artist = "playerctl metadata xesam:artist"
        local get_album  = "playerctl metadata xesam:album"
        
        cmds = {
            { metadata.title, get_title },
            { metadata.artist, get_artist },
            { metadata.album, get_album },
        }

        awful.spawn.easy_async(get_status, 
            function(stdout,_,_,_,_)
                metadata.status = string.gsub(stdout,"\n","")
            end)

        if metadata.status then
            for _,v in pairs(cmds) do
                awful.spawn.easy_async(v[2],
                    function(stdout,_,_,_)
                        v[1] = stdout
                    end)
            end
        else return end

        widget = spotify.widget
        settings()
    end

    newtimer("spotify",timeout,spotify.update)

    return spotify
end

return construct

--[[    set_image = function(self, path)
        self.icon.image = path
    end,[
    set_markup = function(self, path)
        self.current_song.markup = path
    end,
}








local update_widget_icon = function(widget, stdout, _, _, _)
    stdout = string.gsub(stdout, "\n", "")
    if (stdout == 'RUNNING') then
        widget:set_image(PATH_TO_ICONS .. "/play.png")--"/24/actions/player_play.svg")
    elseif (stdout == "CORKED") then
        widget:set_image(PATH_TO_ICONS .. "/pause.png")--"/24/actions/player_pause.svg")
    else
        widget:set_image(nil)
    end
end

local update_widget_text = function(widget, stdout, _, _, _)
    if string.find(stdout, 'Error: Spotify is not running.') ~= nil then
        widget:set_markup('')
        widget:set_visible(false)
    else
        widget:set_markup("<span fgcolor='#474747' weight='bold'>" .. stdout .. "</span>")
        widget:set_visible(true)
    end
end

watch(GET_SPOTIFY_STATUS_CMD, 1, update_widget_icon, spotify_widget)
watch(GET_CURRENT_SONG_CMD, 1, update_widget_text, spotify_widget)
--]]
--[[
-- Adds mouse control to the widget:
--  - left click - play/pause
--  - scroll up - play next song
--  - scroll down - play previous song --]]
--[[spotify_widget:connect_signal("button::press", function(_, _, _, button)
    if (button == 1) then awful.spawn("sp play", false)      -- left click
    elseif (button == 4) then awful.spawn("sp next", false)  -- scroll up
    elseif (button == 5) then awful.spawn("sp prev", false)  -- scroll down
    end
    awful.spawn.easy_async(GET_SPOTIFY_STATUS_CMD, function(stdout, stderr, exitreason, exitcode)
        update_widget_icon(spotify_widget, stdout, stderr, exitreason, exitcode)
    end)
end)--]]
