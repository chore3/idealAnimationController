vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local safeAnim = require("modules/safeAnim")
local stateHandler = require("modules/stateHandler")
local util = require("modules/util")

-- ==================================================

stateHandler.onIdle(function()

end)

stateHandler.onWalk(function()

end)

stateHandler.onSprint(function()

end)

stateHandler.onCrouch(function()

end)

stateHandler.onJump(function()

end)

stateHandler.onSwim(function()

end)

stateHandler.onGlide(function()

end)

stateHandler.onClimb(function()

end)

stateHandler.onFall(function()

end)

stateHandler.onBlock(function()

end)

stateHandler.onChat(function()

end)

stateHandler.onInventory(function()

end)

stateHandler.onFishing(function()

end)

stateHandler.onRiptide(function()

end)

stateHandler.onSleep(function()

end)

stateHandler.onDye(function()

end)

-- ==================================================

function events.tick()
    safeAnim.setPlayIfExists(animations.model, "unexpected", true)
    safeAnim.setPlayIfExists(animations.skull, "sample", true)
    log(util.getUnexpectedAnimations(animations.model, stateHandler.states))
end
