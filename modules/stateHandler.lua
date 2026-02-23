local stateHandler = {}

-- ==================================================

local function noop() end

local states = {
    idle      = { current = false, prev = false, onEvent = noop },
    walk      = { current = false, prev = false, onEvent = noop },
    sprint    = { current = false, prev = false, onEvent = noop },
    crouch    = { current = false, prev = false, onEvent = noop },
    jump      = { current = false, prev = false, onEvent = noop },
    swim      = { current = false, prev = false, onEvent = noop },
    glide     = { current = false, prev = false, onEvent = noop },
    climb     = { current = false, prev = false, onEvent = noop },
    fall      = { current = false, prev = false, onEvent = noop },

    block     = { current = false, prev = false, onEvent = noop },
    chat      = { current = false, prev = false, onEvent = noop },
    inventory = { current = false, prev = false, onEvent = noop },
    fishing   = { current = false, prev = false, onEvent = noop },
    riptide   = { current = false, prev = false, onEvent = noop },
    sleep     = { current = false, prev = false, onEvent = noop },
    dye       = { current = false, prev = false, onEvent = noop },
}

local function setState(name, value)
    local st = states[name]
    if not st then return end

    st.prev = st.current
    st.current = value

    if st.current and not st.prev then
        st.onEvent()
    end
end

local publicStates = {}
local function syncPublicStates()
    for name, st in pairs(states) do
        publicStates[name] = st.current
    end
end

-- ==================================================

function events.tick()
    local v = player:getVelocity()
    local onGround = player:isOnGround()

    setState("idle", v.xz:length() < 0.05 and onGround)
    setState("walk", v.xz:length() > 0.2 and onGround)
    setState("crouch", player:isCrouching())
    setState("sprint", player:isSprinting() and onGround)
    
    syncPublicStates()
end

-- ==================================================


for name, st in pairs(states) do
    stateHandler["is" .. name:gsub("^%l", string.upper)] = function() return st.current end
    stateHandler["on" .. name:gsub("^%l", string.upper)] = function(fn) st.onEvent = fn or noop end
end
return stateHandler