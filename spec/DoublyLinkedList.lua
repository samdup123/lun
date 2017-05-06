local function NewDoublyLinkedList(currentLink)
  local currentLink = currentLink or {}

  local function findLastLink()
    if not currentLink.next then return currentLink
    else findLastLink(currentLink.next) end
  end

  local function findFirstLink()
    if not currentLink.prev then return currentLink
    else findFirstLink(currentLink.prev) end
  end

  local function insert(previousLink, nextLink, data)
    local newLink = NewDoublyLinkedList({ prev = previousLink, data = data, next = nextLink })
    previousLink.next = newLink
    nextLink.prev = newLink
  end

  return {
    addToEnd = function(data)
      if currentLink.data then
        local lastLink = {}
        lastLink = findLastLink()
        lastLink.next = NewDoublyLinkedList({ prev = lastLink, data = data })
        print('1', lastLink.next)
      else
        currentLink.data = data
      end
    end,

    addJustAfter = function(data)
      if currentLink.data then
          insert(currentLink, currentLink.next, data)
      end
    end,

    addToBeginning = function(data)
      if currentLink.data then
        local firstLink = {}
        firstLink = findFirstLink()
        firstLink.prev = NewDoublyLinkedList({ data = data, next = firstLink })
      else
        currentLink.data = data
      end
    end,

    addJustBefore = function(data)
      if currentLink.data then
          insert(currentLink.prev, currentLink, data)
          print('2', currentLink.prev)
      end
    end,

    getDataFromLink = function()
      if not currentLink.data then return nil end
      return currentLink.data
    end,

    getNextLink = function()
      if not currentLink.next then print('no next') end
      print(currentLink.next)
      print(currentLink.next.getDataFromLink)
      return currentLink.next
    end,

    getPreviousLink = function()
      if not currentLink.data then end
      if not currentLink.prev.data then end
      return currentLink.prev
    end
  }
end

return NewDoublyLinkedList
