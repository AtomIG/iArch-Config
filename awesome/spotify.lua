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
        status = nil,
        title  = nil,
        artist = nil,
        album  = nil,
    }
    
    function spotify.update()
        local get_status = "playerctl status"
        local get_title  = "playerctl metadata xesam:title"
        local get_artist = "playerctl metadata xesam:artist"
        local get_album  = "playerctl metadata xesam:album"
        

        awful.spawn.easy_async(get_status, 
            function(stdout,_,_,_,_)
                metadata.status = string.gsub(stdout,"\n","")
            end)

        if metadata.status then
            awful.spawn.easy_async(get_title, 
                function(stdout,_,_,_,_)
                    metadata.title = stdout
                end)

            awful.spawn.easy_async(get_artist, 
            function(stdout,_,_,_,_)
                metadata.artist = stdout
            end)

            awful.spawn.easy_async(get_album, 
            function(stdout,_,_,_,_)
                metadata.album = stdout
            end)
        else return end

        widget = spotify.widget
        settings()
    end

    newtimer("spotify",timeout,spotify.update)

    return spotify
end

return construct
