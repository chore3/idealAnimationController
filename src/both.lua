local safeAnim = require("modules/safeAnim")

-- ==================================================

function pings.tglHalo(bool)
    models.model.Halo:setVisible(bool)
end

function pings.waveHand()
    safeAnim.setPlayIfExists(animations.model, "nonExclusiveAnimation", true)
end
