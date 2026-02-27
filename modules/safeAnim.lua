local safeAnim = {}

function safeAnim.isExists(model, name)
    if model then
        return model[name] ~= nil
    end
    return false
end

-- Play/Stop
function safeAnim.playIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:play()
    end
end

function safeAnim.stopIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:stop()
    end
end

function safeAnim.pauseIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:pause()
    end
end

function safeAnim.restartIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:restart()
    end
end

function safeAnim.setPlayIfExists(model, name, bool)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:setPlaying(bool)
    end
end

function safeAnim.isExistsAndPlaying(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:isPlaying()
    end
end


function safeAnim.isExistsAndStopped(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:isStopped()
    end
end

function safeAnim.isExistsAndPaused(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:isPaused()
    end
end

function safeAnim.getPlayStateIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getPlayState()
    end
end

-- Timing
function safeAnim.setSpeedIfExists(model, name, speed)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setSpeed(speed)
    end
end

function safeAnim.getSpeedIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getSpeed()
    end
end

function safeAnim.setLengthIfExists(model, name, length)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setLength(length)
    end
end

function safeAnim.getLengthIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getLength()
    end
end

function safeAnim.setPriorityIfExists(model, name, priority)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setPriority(priority)
    end
end

function safeAnim.getPriorityIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getPriority()
    end
end

function safeAnim.setTimeIfExists(model, name, time)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setTime(time)
    end
end

function safeAnim.getTimeIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getTime()
    end
end

function safeAnim.setOffsetIfExists(model, name, offset)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setOffset(offset)
    end
end

function safeAnim.getOffsetIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getOffset()
    end
end

function safeAnim.setLoopIfExists(model, name, loop)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setLoop(loop)
    end
end

function safeAnim.getLoopIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getLoop()
    end
end

function safeAnim.setBlendIfExists(model, name, blend)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setBlend(blend)
    end
end

function safeAnim.getBlendIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getBlend()
    end
end

function safeAnim.setStartDelayIfExists(model, name, delay)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setStartDelay(delay)
    end
end

function safeAnim.getStartDelayIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getStartDelay()
    end
end

function safeAnim.setLoopDelayIfExists(model, name, delay)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setLoopDelay(delay)
    end
end

function safeAnim.getLoopDelayIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getLoopDelay()
    end
end

-- Override
function safeAnim.setOverrideIfExists(model, name, override)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setOverride(override)
    end
end

function safeAnim.setOverrideRotIfExists(model, name, override)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setOverrideRot(override)
    end
end

function safeAnim.getOverrideRotIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getOverrideRot()
    end
end

function safeAnim.setOverridePosIfExists(model, name, override)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setOverridePos(override)
    end
end

function safeAnim.getOverridePosIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getOverridePos()
    end
end

function safeAnim.setOverrideScaleIfExists(model, name, override)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:setOverrideScale(override)
    end
end

function safeAnim.getOverrideScaleIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getOverrideScale()
    end
end

-- safeAnimisc
function safeAnim.getNameIfExists(model, name)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        return anim:getName()
    end
end

function safeAnim.newCodeIfExists(model, name, time, code)
    if safeAnim.isExists(model, name) then
        local anim = model[name]
        anim:newCode(time, code)
    end
end

return safeAnim