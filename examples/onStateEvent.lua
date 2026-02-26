local safeAnim = require("modules/safeAnim")

-- ==================================================

stateHandler.onIdle(function()
    log("idle")
end)

stateHandler.onWalk(function()
    log("walk")
end)

stateHandler.onCrouch(function()
    log("crouch")
end)

stateHandler.onSprint(function()
    log("sprint")
end)

-- ==================================================

stateHandler.onJump(function()
    safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, "onJump", true)
    log("jump")
end)

stateHandler.onFall(function()
    log("fall")
end)

stateHandler.onSwim(function()
    log("swim")
end)

stateHandler.onClimb(function()
    log("climb")
end)

stateHandler.onGlide(function()
    log("glide")
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

stateHandler.onInRain(function()
    log("inRain")
end)

stateHandler.onBurn(function()
    log("burn")
end)

-- ==================================================

stateHandler.onFishing(function()
    log("fishing")
end)

stateHandler.onEat(function()
    log("eat")
end)

stateHandler.onDrink(function()
    log("drink")
end)

stateHandler.onRiptide(function()
    log("riptide")
end)

stateHandler.onSleep(function()
    log("sleep")
end)

stateHandler.onFlying(function()
    log("flying")
end)

stateHandler.onDye(function()
    log("dye")
end)

stateHandler.onGlow(function()
    log("glow")
end)