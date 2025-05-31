-- local function get_script_dir()
--     local info = debug.getinfo(2, "S")   -- Get info about the current script
--     local full_path = info.source:sub(2) -- Remove the "@" prefix
--     return full_path:match("^(.*[\\/])") -- Extract the directory part
-- end
-- package.path = package.path .. ";" .. get_script_dir() .. "?/init.lua" .. ";".. get_script_dir() .."/?.lua"
require("TimeModule.TimeTools")
