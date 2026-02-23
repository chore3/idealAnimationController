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
    inRain = false,
    burn = false,

    fishing = false,
    eat = false,
    drink = false,
    riptide = false,
    sleep = false,
    flying = false,
    dye = false,
    glow = false
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

local function getCurrent(name)
    local st = localState[name]
    return st.current
end

local function syncStates()
    for name, st in pairs(localState) do
        states[name] = st.current
    end
end

-- ==================================================
-- host
local hostStates = {
    jump = { prev = false, current = false, getter = function() end },
    chat = { prev = false, current = false, getter = function()  end },
    inventory = { prev = false, current = false, getter = function() return host:isContainerOpen() end },
    flying = { prev = false, current = false, getter = function() return host:isFlying() end },
}
hostStates.jump.getter = function ()
    return host:isJumping() and not getCurrent("swim") and not getCurrent("glide") and not getCurrent("flying")
end
hostStates.chat.getter = function ()
    if not player:isLoaded() then
        return hostStates.chat.prev
    end
    return not player:getPose() == "SLEEPING" and host:isChatOpen()
end

function events.tick()
    if not host:isHost() then
        return
    end

    for name, st in pairs(hostStates) do
        st.current = st.getter()
        if st.current ~= st.prev then
            pings.updateState(name, st.current)
            st.prev = st.current
        end
    end
end

-- ==================================================
-- both
function pings.updateState(name, bool)
    setState(name, bool)
end

function events.tick()
    local isPlayerLoaded = player:isLoaded()
    local v = isPlayerLoaded and player:getVelocity() or vec(0, 0, 0)
    local onGround = isPlayerLoaded and player:isOnGround() or false
    local safePose = isPlayerLoaded and player:getPose() or "STANDING"

    local isSwimming = safePose == "SWIMMING"
    local isSleeping = safePose == "SLEEPING"
    local isGliding = isPlayerLoaded and player:isGliding() or false
    local isEating = isPlayerLoaded and player:getActiveItem():getUseAction() == "EAT" or false
    local isDrinking = isPlayerLoaded and player:getActiveItem():getUseAction() == "DRINK" or false

    setState("walk", v.xz:length() > 0.2 and onGround and not isSwimming)
    setState("crouch", safePose == "CROUCHING")
    setState("sprint", isPlayerLoaded and (player:isSprinting() and onGround and not isSwimming) or false)

    setState("fall", not onGround and v.y < -0.6 and not isSwimming and not isGliding)
    setState("swim", isSwimming)
    setState("climb", isPlayerLoaded and player:isClimbing() or false)
    setState("glide", isGliding)
    setState("block", isPlayerLoaded and player:isBlocking() or false)

    setState("inRain", isPlayerLoaded and player:isInRain() or false)
    setState("burn", isPlayerLoaded and player:isOnFire() or false)

    setState("fishing", isPlayerLoaded and player:isFishing() or false)
    setState("eat", isEating)
    setState("drink", isDrinking)
    setState("riptide", isPlayerLoaded and player:riptideSpinning() or false)
    setState("sleep", isSleeping)
    setState("dye", safePose == "DYING")
    setState("glow", isPlayerLoaded and player:isGlowing() or false)

    local allOthersFalse = true
    for name, st in pairs(localState) do
        if name ~= "idle" and st.current then
            allOthersFalse = false
            break
        end
    end
    setState("idle", allOthersFalse)

    syncStates()
end

-- ==================================================


for name, st in pairs(localState) do
    stateHandler["is" .. name:gsub("^%l", string.upper)] = function() return st.current end
    stateHandler["on" .. name:gsub("^%l", string.upper)] = function(fn) st.onEvent = fn or noop end
end
stateHandler.states = states
return stateHandler
