local async = api.load_async_tools()
local asyncio = async.io
local json = api.load_json_tools()

Events = {}

print(api.DATA_DIR)

local events_data = api.DATA_DIR .. "events.json"
local function on_exit_save()
   local file = asyncio.open(events_data, "w")
   file:write(json.stringify(Events) .. "\n")
   async.run(future)
end

local function on_start()
   local file = asyncio.open(events_data, "r")
   local content = file:read()
   Events = json.parse(content)
end
--Make sure that it saves on exit
api.on_exit(on_exit_save)

--On startup load the events from before
async.run(on_start)

return Events
