vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local safeAnim = require("modules/safeAnim")
local stateHandler = require("modules/stateHandler")

-- ==================================================


function events.tick()
    log(stateHandler.isIdle())
end
