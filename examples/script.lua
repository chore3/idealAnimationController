vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.ELYTRA:setVisible(false)

_G.EXAMPLE_MODEL_ANIMATIONS = animations["examples.models.model"]

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

local exclusive = {
    idle = 0,
    fishing = 1,
    walk = 2,
    crouch = 3,
    sprint = 4,
    swim = 5,
    climb = 6,
    jump = 7,
    fall = 8,
    glide = 9,
    riptide = 10,
    sleep = 11,
    dye = 12,

    newExclusiveAnimation = 100
}

_G.customStates = {
    newExclusiveAnimation = false
}

if host:isHost() then require("./host") end
require("./both")
-- require("src/onStateEvent")

-- ==================================================

function events.tick()
    local exclusiveAnim = util.getHighestPriorityActiveState(util.mergeTable(stateHandler.states, customStates),
    exclusive)
    if exclusiveAnim == nil then
        exclusiveAnim = "idle"
    end
    for name, _ in pairs(exclusive) do
        safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, name, name == exclusiveAnim)
    end

    safeAnim.setPlayIfExists(animations["examples.models.skull"], "skullAnim", true)
end
