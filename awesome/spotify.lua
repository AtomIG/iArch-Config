local awful = require("awful")
local wibox = require("wibox")
local newtimer = require("lain.helpers").newtimer
local string = string

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
        

            awful.spawn.easy_async(get_status, 
                function(stdout,_,_,_,_)
                    metadata.status = string.gsub(stdout,"\n","")
                end)

            awful.spawn.easy_async(get_title, 
                function(stdout,_,_,_,_)
                    metadata.title = string.gsub(stdout,"\n","")
                end)

            awful.spawn.easy_async(get_artist, 
                function(stdout,_,_,_,_)
                    metadata.artist = string.gsub(stdout,"\n","")
                end)

            awful.spawn.easy_async(get_album, 
                function(stdout,_,_,_,_)
                    metadata.album = stdout
                end)

        widget = spotify.widget
        settings()
    end

    newtimer("spotify",timeout,spotify.update)

    return spotify
end

return construct
