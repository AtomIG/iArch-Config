local wibox = require("wibox")
local open = io.popen
local helpers = require("lain.helpers")

local function factory(args)
    local music     = { widget = wibox.widget.textbox() }
    local args      = args or {}
    local timeout   = args.timeout or 2
    local setting   = args.settings or function() end

    function music.update()
        music_now = {}
        handle = io.popen("echo 'test'", "r")
        music.status = handle:read("*a")
        handle:close()
        music_now.status = music.status

        widget = music.widget
        settings()
    end
    
    helpers.newtimer("music", timeout, music.update)

    return music
end

return factory
