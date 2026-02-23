vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

-- ==================================================

local safeAnim = require("modules/safeAnim")
_G.stateHandler = require("modules/stateHandler")
local util = require("modules/util")

if host:isHost() then require("src/host") end
require("src/both")
-- require("src/onStateEvent")

-- ==================================================

local exclusive = {
    idle = 0,
    walk = 1,
    crouch = 2,
    sprint = 3,
    swim = 4,
    climb = 5,
    jump = 6,
    fall = 7,
    glide = 8,
    fishing = 9,
    riptide = 10,
    sleep = 11,
    dye = 12,

    unexpected = 100
}

local customStates = {
    unexpected = false
}

function events.tick()
    exclusiveAnim = util.getHighestPriorityActiveState(util.mergeTable(stateHandler.states, customStates), exclusive)
    if exclusiveAnim then
        for name, _ in pairs(exclusive) do
            safeAnim.setPlayIfExists(animations.model, name, name == exclusiveAnim)
        end
    else
        safeAnim.setPlayIfExists(animations.model, "idle", true)
    end

    safeAnim.setPlayIfExists(animations.skull, "skullAnim", true)
end
