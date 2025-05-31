local Events = require("TimeModule.Events")
local async = api.load_async_tools()
local http = api.load_request_tools()
local json = api.load_json_tools()
local asyncio = async.io
function get_time()
   return os.date("*t")
end

local function ensure_epoch_time(time)
   if type(time) == "table" then
      local full_table = get_time() --I am doing this to ensure that the table has all needed data
      for key, value in pairs(time) do
         full_table[key] = value
      end
      return os.time(full_table)
   elseif type(time) == "number" then
      return time
   else
      error(string.format("Invalid time type: %s", type(timecd)))
   end
end

function set_timer(time, name)
   local time = ensure_epoch_time(time) + os.time()
   table.insert({ name = name, time = time, type = "timer" })
end

function remove_timer(name)
   for pos, value in ipairs(Events) do
      if value["type"] == "timer" then
         if value.name == name then
            table.remove(Events, pos)
            return "Removed Timer " .. name
         else
            return "Invalid Timer " .. name
         end
      end
   end
end

function check_timer(name)
   for pos, value in ipairs(Events) do
      if value["type"] == "timer" then
         if value.name == name then
            return value - os.time()
         end
      end
   end
end

local function handle_timer(timer)
   if timer["time"] <= os.time() then
      --TODO
   end
end

local function handle_alarm(alarm)
   local current = get_time()
   for _, day in ipairs(alarm["table"]["days"]) do
      if current.wday == day then
         if current.hour == alarm["table"]["hour"] and current.min == alarm["table"]["min"] then
            --Play Alarm somehow I don't know how I want to do this
            break
         end
      end
   end
end

function time_event_loop()
   while true do
      for _, event in ipairs(Events) do
         if event["type"] == "timer" then
            handle_timer(event)
         elseif event["type"] == "alarm" then
            handle_alarm(event)
         end
      end
      async.sleep(0)
   end
end
