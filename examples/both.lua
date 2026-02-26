local safeAnim = require("modules/safeAnim")

-- ==================================================

function pings.tglNewExclusiveAnimation(bool)
    customStates.newExclusiveAnimation = bool
end

function pings.tglHalo(bool)
    models.examples.models.model.Halo:setVisible(bool)
end

function pings.waveHand()
    safeAnim.setPlayIfExists(modelAnimations, "nonExclusiveAnimation", true)
end
