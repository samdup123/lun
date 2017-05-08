local EventManager = {}
EventManager.__index = EventManager


local getTime = function()
  local file = io.popen('date +%s%3N')
  local time = file:read('*a')
  file:close()
  return tonumber(time)
end

function EventManager:ScheduleEvent(newEventCallback, ticksTillItHappens)
  print('scheduling')
  self.events.callback = newEventCallback
  self.events.goTime = tonumber(getTime() + ticksTillItHappens)
  print(self.events.goTime)
end

function EventManager:StartEventLoop()
  while true do
    local currentTime = getTime()
    print('currentTime', currentTime)
    if not self.events.goTime then print('break'); break end
    if currentTime >= self.events.goTime then
      print('event is ready to go')
      self.events.callback()
      self.events = self.events.nextEvent or {}
    else
      local butts = 'sleep ' .. (self.events.goTime - currentTime)/1000 .. 's'
      print('sleeping', butts)
      os.execute(butts)
      print('done sleeping')
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
