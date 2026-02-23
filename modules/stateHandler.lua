local stateHandler = {}

-- ==================================================

local function noop() end

local states = {
    idle = false,
    walk = false,
    crouch = false,
    sprint = false,
    jump = false,
    fall = false,
    swim = false,
    climb = false,
    glide = false,
    block = false,
    chat = false,
    inventory = false,
    fishing = false,
    riptide = false,
    sleep = false,
    dye = false
}

local localState = {}
for name in pairs(states) do
    localState[name] = { current = false, prev = false, onEvent = noop }
end

local function setState(name, value)
    local st = localState[name]
    if not st then return end

    st.prev = st.current
    st.current = value

    if st.current and not st.prev then
        st.onEvent()
    end
end

local function syncStates()
    for name, st in pairs(localState) do
        states[name] = st.current
    end
end

-- ==================================================

function events.tick()
    local isPlayerLoaded = player:isLoaded()
    local v = isPlayerLoaded and player:getVelocity() or vec(0, 0, 0)
    local onGround = isPlayerLoaded and player:isOnGround() or false
    local safePose = isPlayerLoaded and player:getPose() or "STANDING"

    setState("idle", v.xz:length() < 0.05 and onGround)
    setState("walk", v.xz:length() > 0.2 and onGround)
    setState("crouch", player:isCrouching())
    setState("sprint", player:isSprinting() and onGround)

    syncStates()
end

-- ==================================================


for name, st in pairs(localState) do
    stateHandler["is" .. name:gsub("^%l", string.upper)] = function() return st.current end
    stateHandler["on" .. name:gsub("^%l", string.upper)] = function(fn) st.onEvent = fn or noop end
end
stateHandler.states = states
return stateHandler
