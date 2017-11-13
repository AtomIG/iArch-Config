local awful = require("awful")
local wibox = require("wibox")
local newtimer = require("lain.helpers").newtimer
local string = string


local function construct(args)
    local spotify  = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 3
    local settings = args.settings or function() end

-- Note that metadata.status,metadata.title,metadata.artist, and metadata.album will never take on a value of nil. Instead, when there is no player available, they will report values of "". Code used in constructing the widget (i.e. the settings function) should be made accordingly.

    metadata = {
        status = "",
        title  = "",
        artist = "",
        album  = "",
    }
    
    function spotify.update()
        local get_status = "playerctl status"
        local get_title  = "playerctl metadata xesam:title"
        local get_artist = "playerctl metadata xesam:artist"
        local get_album  = "playerctl metadata xesam:album"
        

            awful.spawn.easy_async(get_status, 
                function(stdout,stderr,_,_,_)
                    if stderr == "" then
                        stdout = string.gsub(stdout,"\n","")
                            if stdout == 'Not available' then
                                metadata.status = ""
                            else metadata.status = stdout end
                    else metadata.status = "" end
                end)

            awful.spawn.easy_async(get_title, 
                function(stdout,stderr,_,_,_)
                    if stderr == "" then
                        metadata.title = string.gsub(stdout,"\n","")
                    else metadata.title = "" end
                end)

            awful.spawn.easy_async(get_artist, 
                function(stdout,stderr,_,_,_)
                    if stderr == "" then
                        metadata.artist = string.gsub(stdout,"\n","")
                    else metadata.artist = "" end
                end)

            awful.spawn.easy_async(get_album, 
                function(stdout,stderr,_,_,_)
                    if stderr == "" then
                        metadata.album = string.gsub(stdout,"\n","")
                    else metadata.album = "" end
                end)

-- To do: Make it so that the spotify widget will have a much larger timeout when music is not playing
-- or, alternatively, to set up signals so that the widget will only query playerctl if spotify is open

        widget = spotify.widget
        settings()
    end

    newtimer("spotify",timeout,spotify.update)

    return spotify
end

return construct
