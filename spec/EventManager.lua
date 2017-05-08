local EventManager = {}
EventManager.__index = EventManager


local getTime = function()
  local file = io.popen('date +%s%3N')
  local time = file:read('*a')
  file:close()
  return tonumber(time)
end

function EventManager:ScheduleEvent(newEventCallback, ticksTillItHappens)
  self.events.callback = newEventCallback
  self.events.goTime = tonumber(getTime() + ticksTillItHappens)
  print(self.events.goTime)
end

function EventManager:StartEventLoop()
  while true do
    local currentTime = getTime()
    if not self.events.goTime then break end
    if currentTime >= self.events.goTime then
      self.events.callback()
      self.events = self.events.nextEvent or {}
    else
      local osCommand = 'sleep ' .. (self.events.goTime - currentTime)/1000 .. 's'
      os.execute(osCommand)
    end
  end
end

function EventManager.Init(firstEvent)
  local obj = {}
  obj.events = {}
  local instance = setmetatable(obj, EventManager)
  firstEvent(instance)
  instance:StartEventLoop()
end

return EventManager
