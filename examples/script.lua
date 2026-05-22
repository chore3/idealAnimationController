vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

_G.EXAMPLE_MODEL_ANIMATIONS = animations["examples.models.model"]

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

local exclusiveAnimationsMap = {
    noneActive = 0,
    idle = 10,
    fishing = 20,
    sprint = 30,
    walk = 40,
    crouch = 50,
    swim = 60,
    climb = 70,
    fall = 80,
    glide = 90,
    riptide = 100,
    sleep = 110,
    die = 120,

    newExclusiveAnimation = 1000
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
        exclusiveAnimList = { "noneActive" }
    end
    for name, _ in pairs(exclusiveAnimationsMap) do
        safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, name, util.table.containsValue(exclusiveAnimList, name))
    end
end
