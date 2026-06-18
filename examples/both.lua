local safeAnim = require("modules/safeAnim")
local physicsObjects = require("modules/physicsObjects")
local util = require("modules/util")

-- ==================================================

function pings.tglNewExclusiveAnimation(bool)
    customStates.newExclusiveAnimation = bool
end

function pings.tglHalo(bool)
    models.examples.models.model.Halo:setVisible(bool)
end

function pings.waveHand()
    safeAnim.setPlayIfExists(EXAMPLE_MODEL_ANIMATIONS, "nonExclusiveAnimation", true)
end

function pings.spawnExampleMissile(pos, dir)
    physicsObjects.new({
        model = models.examples.models.missile.root,
        position = pos,
        init = function(self)
            self.velocity = dir:normalized() * 0.5
            self.roll = 0
            util.setPartDirFromUp(self.part, self.position, self.velocity, self.roll)
        end,
        tick = function(self)
            local isBlocked = physicsObjects.probeNextBlock(self, self.velocity)
            if isBlocked or self.age > 80 then
                self:destroy()
                return
            end

            self.position = self.position + self.velocity
            util.setPartDirFromUp(self.part, self.position, self.velocity, self.roll)
        end,
    })
end
