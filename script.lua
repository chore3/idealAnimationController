vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)

local safeAnim = require("safeAnim")
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

    if jumping then
        safeAnim.restartIfExists(animations.model, "jump")
        jumping = nil
    end
    if jumping == nil and is_on_ground then
        if safeAnim.isExistsAndPlaying(animations.model, "fall") and not is_moving then
            safeAnim.restartIfExists(animations.model, "land")
        end
        jumping = false
    end
    if is_moving then
        safeAnim.stopIfExists(animations.model, "land")
    end
    
    safeAnim.setPlayIfExists(animations.model, "block", is_blocking)
    safeAnim.setPlayIfExists(animations.model, "glide", is_gliding and not is_blocking)
    safeAnim.setPlayIfExists(animations.model, "crouch", is_crouching and not is_gliding and not is_blocking)
    safeAnim.setPlayIfExists(animations.model, "climb", is_climbing and not is_crouching and not is_gliding and not is_blocking)
    safeAnim.setPlayIfExists(animations.model, "sprint", is_sprinting and not is_climbing and not is_crouching and not is_gliding and not is_blocking and is_on_ground)
    safeAnim.setPlayIfExists(animations.model, "walk", is_walking and not is_sprinting and not is_climbing and not is_crouching and not is_gliding and not is_blocking and is_on_ground)
    safeAnim.setPlayIfExists(animations.model, "idle", not is_walking and not is_sprinting and not is_climbing and not is_crouching and not is_gliding and not is_blocking and is_on_ground)
    safeAnim.setPlayIfExists(animations.model, "fall", is_falling and not is_gliding and not safeAnim.isExistsAndPlaying(animations.model, "jump"))

end


-- host:screenshot()で返したテクスチャを顔に貼り付けてみよう