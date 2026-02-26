local safeAnim = require("modules/safeAnim")

-- ==================================================

function pings.tglNewExclusiveAnimation(bool)
    customStates.newExclusiveAnimation = bool
end

function pings.tglHalo(bool)
    models.model.Halo:setVisible(bool)
end

function pings.waveHand()
    safeAnim.setPlayIfExists(animations.model, "nonExclusiveAnimation", true)
end
