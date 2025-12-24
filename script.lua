vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

require("safeAnim")
local jumping = false
function events.tick()
    local velocity_y = player:getVelocity().y
    local is_crouching = player:isCrouching()
    local is_walking = player:getVelocity().xz:length() > .01
    local is_sprinting = player:isSprinting()
    local is_on_ground = player:isOnGround()
    local is_falling = not is_on_ground and velocity_y < -0.6 or false
    local is_moving = player:getVelocity().xz:length() > 0.2

    local is_blocking = player:isBlocking()
    local is_climbing = player:isClimbing()
    local is_gliding = player:isGliding()
    local is_swimming = player:isVisuallySwimming()
    jumping = (jumping == false) and (not is_on_ground and velocity_y > 0) or jumping

    local animTbl = animations.model
    if jumping then
        restartIfExists(animTbl, "jump")
        jumping = nil
    end
    if jumping == nil and is_on_ground then
        if isExistsAndPlaying(animTbl, "fall") and not is_moving then
            restartIfExists(animTbl, "land")
        end
        jumping = false
    end
    if is_moving then
        stopIfExists(animTbl, "land")
    end
    setPlayIfExists(animTbl, "crouch", is_crouching and not jumping)
    setPlayIfExists(animTbl, "sprint", is_sprinting and not is_crouching and not jumping and is_on_ground)
    setPlayIfExists(animTbl, "walk", is_walking and not is_crouching and not is_sprinting and not jumping and is_on_ground)
    setPlayIfExists(animTbl, "idle", not is_walking and not is_crouching and not jumping and is_on_ground)
    setPlayIfExists(animTbl, "fall", is_falling and not isExistsAndPlaying(animTbl, "jump"))

end


-- host:screenshot()で返したテクスチャを顔に貼り付けてみよう