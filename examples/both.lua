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

-- bbmodel が +Y（上向き）を正面として作られている前提で、
-- direction ベクトルへ向ける回転を設定する
local function setPartDirFromUp(part, direction)
    if not direction or direction:length() == 0 then
        return
    end
    local dir = direction:normalized()
    local rotX = math.deg(math.asin(math.max(-1, math.min(1, dir.z))))
    local rotZ = math.deg(math.atan(-dir.x, dir.y))
    part:setRot(rotX, 0, rotZ)
end

function pings.spawnExampleMissile(pos, dir)
    physicsObjects.new({
        model = models.examples.models.missile.root,
        position = pos,
        init = function(self)
            self.velocity = dir * 0.8
            setPartDirFromUp(self.part, dir)
        end,
        tick = function(self)
            self.velocity = self.velocity + vec(0, -0.01, 0)
            setPartDirFromUp(self.part, self.velocity)

            local isBlocked = physicsObjects.probeNextBlock(self, self.velocity)
            if isBlocked or self.age > 80 then
                self:destroy()
                return
            end

            self.position = self.position + self.velocity
            self.part:setPos(util.worldToModelPos(self.position))
        end,
    })
end
