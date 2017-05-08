local EventManager = require('EventManager')

local errorMilliseconds = 10

local function getTime()
  local file = io.popen('date +%s%3N')
  local time = file:read('*a')
  file:close()
  return tonumber(time)
end

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
    local outputTable = {}
    local function addTimeToOutputTable() table.insert(outputTable, getTime()) end

    local function scheduleAnotherEvent(eventManager)
      eventManager:ScheduleEvent(addTimeToOutputTable, 100)
    end
    local expectedTime = getTime() + 100
    EventManager.Init(scheduleAnotherEvent)

    print('timeDiff', math.abs(outputTable[1] - expectedTime))
    assert.is_true(math.abs(outputTable[1] - expectedTime) <= errorMilliseconds)
  end)

end)
