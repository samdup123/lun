local EventManagerCallback_Spy = {}

function EventManagerCallback_Spy.Init(callback)
  local obj = {}
  obj.callback = callback
  return setmetatable(obj, EventManagerCallback_Spy)
end

return EventManagerCallback_Spy
