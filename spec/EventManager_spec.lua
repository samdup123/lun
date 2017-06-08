local EventManager = require('EventManager')

local mock = require('mach')

local firstEvent = mock.mock_function('firstEvent')

local newEvent = mock.mock_function('newEvent')

local function scheduleAnotherEvent(eventManager)
  eventManager:ScheduleEvent(newEvent, 10)
end

local function scheduleTwoEvents(eventManager)
  eventManager:ScheduleEvent(newEvent, 10)
  eventManager:ScheduleEvent(newEvent, 20)
end

describe('EventManager', function()

  it('Should add starter event and then sleep after that', function()

    firstEvent:should_be_called_with_any_arguments():when(
    function()
      EventManager.Init(firstEvent)
    end)

  end)

  it('Should be able to schedule another event during the first event', function()

    newEvent:should_be_called_with_any_arguments():when(
      function()
        EventManager.Init(scheduleAnotherEvent)
    end)

  end)

  it('Should be able to schedule two events during first event', function()
    
    newEvent:should_be_called():
    and_also(newEvent:should_be_called()):
    when(
      function()
        EventManager.Init(scheduleTwoEvents)
    end)
    
  end)

end)
