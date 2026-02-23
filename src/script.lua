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
    dye = 12
}
function events.tick()
    exclusiveAnim = util.getHighestPriorityActiveState(stateHandler.states, exclusive)
    if exclusiveAnim then
        for name, _ in pairs(exclusive) do
            if name == exclusiveAnim then
                safeAnim.playIfExists(animations.model, exclusiveAnim)
            else
                safeAnim.stopIfExists(animations.model, name)
            end
        end
    else
        safeAnim.playIfExists(animations.model, "idle")
    end

    safeAnim.setPlayIfExists(animations.skull, "skullAnim", true)
end
