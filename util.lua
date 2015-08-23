function table.ordered(fcomp)
    local newmetatable = {}

    -- sort func
    newmetatable.fcomp = fcomp

    -- sorted subtable
    newmetatable.sorted = {}

    -- behavior on new index
    function newmetatable.__newindex(t, key, value)
        if type(key) == "string" then
            local fcomp = getmetatable(t).fcomp
            local tsorted = getmetatable(t).sorted
            table.binsert(tsorted, key , fcomp)
            rawset(t, key, value)
        end
    end

    -- behaviour on indexing
    function newmetatable.__index(t, key)
        if key == "n" then
            return table.getn( getmetatable(t).sorted )
        end
        local realkey = getmetatable(t).sorted[key]
        if realkey then
            return realkey, rawget(t, realkey)
        end
    end

    local newtable = {}

    -- set metatable
    return setmetatable(newtable, newmetatable)
end

--// table.binsert( table, value [, comp] )
--
-- LUA 5.x add-on for the table library.
-- Does binary insertion of a given value into the table
-- sorted by [,fcomp]. fcomp is a comparison function
-- that behaves like fcomp in in table.sort(table [, fcomp]).
-- This method is faster than doing a regular
-- table.insert(table, value) followed by a table.sort(table [, comp]).
function table.binsert(t, value, fcomp)
    -- Initialise Compare function
    local fcomp = fcomp or function( a, b ) return a < b end

    --  Initialise Numbers
    local iStart, iEnd, iMid, iState =  1, table.getn( t ), 1, 0

    -- Get Insertposition
    while iStart <= iEnd do
        -- calculate middle
        iMid = math.floor( ( iStart + iEnd )/2 )

        -- compare
        if fcomp( value , t[iMid] ) then
            iEnd = iMid - 1
            iState = 0
        else
            iStart = iMid + 1
            iState = 1
        end
    end

    local pos = iMid+iState
    table.insert( t, pos, value )
    return pos
end

-- Iterate in ordered form
-- returns 3 values i, index, value
-- ( i = numerical index, index = tableindex, value = t[index] )
function orderedPairs(t)
    return orderedNext, t
end
function orderedNext(t, i)
    i = i or 0
    i = i + 1
    local index = getmetatable(t).sorted[i]
    if index then
        return i, index, t[index]
    end
end

List = {}
function List.new ()
  return {first = 0, last = -1}
end

function List.pushleft (list, value)
  local first = list.first - 1
  list.first = first
  list[first] = value
end

function List.pushright (list, value)
  local last = list.last + 1
  list.last = last
  list[last] = value
end

function List.popleft (list)
  local first = list.first
  if first > list.last then error("list is empty") end
  local value = list[first]
  list[first] = nil        -- to allow garbage collection
  list.first = first + 1
  return value
end

function List.popright (list)
  local last = list.last
  if list.first > last then error("list is empty") end
  local value = list[last]
  list[last] = nil         -- to allow garbage collection
  list.last = last - 1
  return value
end
