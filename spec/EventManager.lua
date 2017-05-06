local defaultTimeSpecificConstant = 2
local timeSpecificConstanInUse = defaultTimeSpecificConstant

local currentTime = 0

local currentTableIndex = 1

local function getTime()
  local file = io.popen('date +%s%' .. timeIncrementSpecificConstant .. 'N')
  local time = file:read('*a')
  file:close()
  currentTime = time
end

local events = {}

local function addEvent(callback, ticksUntilEventTakesPlace)
  -- for i = currentTableIndex
end


return function(newEventCallback, ticksUntilEventTakesPlace)
  getTime()
  local newEvent = { callback = newEventCallback, timeToHappen = ticksLeftBeforeEventTakesPlace + currentTime }
  table.insert(events, eventCallback)
end
