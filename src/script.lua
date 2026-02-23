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

function events.tick()
    safeAnim.setPlayIfExists(animations.skull, "skullAnim", true)
end