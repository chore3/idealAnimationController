vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

_G.EXAMPLE_MODEL_ANIMATIONS = animations["examples.models.model"]

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

local exclusiveAnimationsMap = {
    idle = 0,
    fishing = 1,
    sprint = 2,
    walk = 3,
    crouch = 4,
    swim = 5,
    climb = 6,
    fall = 7,
    glide = 8,
    riptide = 9,
    sleep = 10,
    die = 11,

    newExclusiveAnimation = 100
}

_G.customStates = {
    newExclusiveAnimation = false
}

if host:isHost() then require("./host") end
require("./both")
require("./onStateEvent")

-- ==================================================

function events.tick()
    local exclusiveAnimList = util.getHighestPriorityActivePlayableStateList(
        EXAMPLE_MODEL_ANIMATIONS,
        util.table.merge(stateHandler.states, customStates),
        exclusiveAnimationsMap
    )
    if #exclusiveAnimList == 0 then
        exclusiveAnimList = { "idle" }
    end
    for name, _ in pairs(exclusiveAnimationsMap) do
        safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, name, util.table.containsValue(exclusiveAnimList, name))
    end
end
