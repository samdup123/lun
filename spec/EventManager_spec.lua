local EventManager = require('EventManager')

local errorMilliseconds = 2

local function getTime()
  local file = io.popen('date +%s%2N')
  local time = file:read('*a')
  file:close()
  return tonumber(time)
end

local output = 0
local function addTimeToOutput() output = getTime() end

describe('EventManager', function()

  it('Should add starter event and then sleep after that', function()
    local mock = require('mach')
    local firstEvent = mock.mock_function('firstEvent')

    firstEvent:should_be_called_with_any_arguments():when(
    function()
      local eventManager = EventManager.Init(firstEvent)
    end)

  end)

  it('Should be able to schedule another event during the first event', function()
    local timeTillItHappens = 10

    local function scheduleAnotherEvent(eventManager)
      eventManager:ScheduleEvent(addTimeToOutput, timeTillItHappens)
    end

    local expectedTime = getTime() + timeTillItHappens
    EventManager.Init(scheduleAnotherEvent)

    assert.is_true(math.abs(output - expectedTime) <= errorMilliseconds)
  end)

  it('Should be able to schedule an event that happens very soon', function()
    local timeTillItHappens = 2

    local function scheduleAnotherEvent(eventManager)
      eventManager:ScheduleEvent(addTimeToOutput, timeTillItHappens)
    end

    local expectedTime = getTime() + timeTillItHappens
    EventManager.Init(scheduleAnotherEvent)

    assert.is_true(math.abs(output - expectedTime) <= errorMilliseconds)
  end)

end)
