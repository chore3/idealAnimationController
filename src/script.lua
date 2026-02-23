vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local safeAnim = require("modules/safeAnim")
local stateHandler = require("modules/stateHandler")
local util = require("modules/util")

-- ==================================================


function events.tick()
    safeAnim.setPlayIfExists(animations.model, "unexpected", true)
    safeAnim.setPlayIfExists(animations.skull, "sample", true)
    log(util.getUnexpectedAnimations(animations.model, stateHandler.states))
end
