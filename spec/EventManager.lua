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
  self.lastEvent.nextEvent = {}
  self.lastEvent.nextEvent.callback = newEventCallback
  self.lastEvent.nextEvent.goTime = tonumber(getTime() + ticksTillItHappens)
  self.lastEvent = self.lastEvent.nextEvent
end

function EventManager:StartEventLoop()
  while true do
    local currentTime = getTime()
    if not self.events.goTime then break end
    self.events.callback()
    self.events = self.events.nextEvent or {}
  end
end

function EventManager.Init(firstEvent)
  local obj = {}
  obj.events = {callback = function() end, goTime = 0}
  obj.lastEvent = obj.events
  local instance = setmetatable(obj, EventManager)
  firstEvent(instance)
  instance:StartEventLoop()
end

return EventManager
