local EventManager = {}
EventManager.__index = EventManager

local timeStepBashCommandConstant = 3

local getTime = function()
  local file = io.popen('date +%s%2N')
  local time = file:read('*a')
  file:close()
  return tonumber(time)
end

function EventManager:ScheduleEvent(newEventCallback, ticksTillItHappens)
  self.events.callback = newEventCallback
  self.events.goTime = tonumber(getTime() + ticksTillItHappens)
end

function EventManager:StartEventLoop()
  while true do
    local currentTime = getTime()
    if not self.events.goTime then break end
    if currentTime >= self.events.goTime then
      self.events.callback()
      self.events = self.events.nextEvent or {}
    else
      print('sleep', 'sleep ' .. (self.events.goTime - currentTime)/100 .. 's')
      local osCommand = 'sleep ' .. (self.events.goTime - currentTime)/100 .. 's'
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
