vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local safeAnim = require("modules/safeAnim")
local stateHandler = require("modules/stateHandler")
local util = require("modules/util")

-- ==================================================

stateHandler.onIdle(function()
    log("idle")
end)

stateHandler.onWalk(function()
    log("walk")
end)

stateHandler.onSprint(function()
    log("sprint")
end)

stateHandler.onCrouch(function()
    log("crouch")
end)

stateHandler.onJump(function()
    log("jump")
end)

stateHandler.onSwim(function()
    log("swim")
end)

stateHandler.onGlide(function()
    log("glide")
end)

stateHandler.onClimb(function()
    log("climb")
end)

stateHandler.onFall(function()
    log("fall")
end)

stateHandler.onBlock(function()
    log("block")
end)

stateHandler.onChat(function()
    log("chat")
end)

stateHandler.onInventory(function()
    log("inventory")
end)

stateHandler.onFishing(function()
    log("fishing")
end)

stateHandler.onRiptide(function()
    log("riptide")
end)

stateHandler.onSleep(function()
    log("sleep")
end)

stateHandler.onDye(function()
    log("dye")
end)

-- ==================================================

function events.tick()
    safeAnim.setPlayIfExists(animations.model, "unexpected", true)
    safeAnim.setPlayIfExists(animations.skull, "skullAnim", true)
end
