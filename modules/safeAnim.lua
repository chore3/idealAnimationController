local safeAnim = {}

-- Play/Stop
function safeAnim.playIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:play()
        end
    end
end

function safeAnim.stopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:stop()
        end
    end
end

function safeAnim.pauseIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:pause()
        end
    end
end

function safeAnim.restartIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:restart()
        end
    end
end

function safeAnim.setPlayIfExists(model, name, bool)
    if model then
        local anim = model[name]
        if anim then
            return anim:setPlaying(bool)
        end
    end
end

function safeAnim.isExistsAndPlaying(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPlaying()
        end
    end
end


function safeAnim.isExistsAndStopped(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isStopped()
        end
    end
end

function safeAnim.isExistsAndPaused(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPaused()
        end
    end
end

function safeAnim.getPlayStateIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPlayState()
        end
    end
end

-- Timing
function safeAnim.setSpeedIfExists(model, name, speed)
    if model then
        local anim = model[name]
        if anim then
            anim:setSpeed(speed)
        end
    end
end

function safeAnim.getSpeedIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getSpeed()
        end
    end
end

function safeAnim.setLengthIfExists(model, name, length)
    if model then
        local anim = model[name]
        if anim then
            anim:setLength(length)
        end
    end
end

function safeAnim.getLengthIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLength()
        end
    end
end

function safeAnim.setPriorityIfExists(model, name, priority)
    if model then
        local anim = model[name]
        if anim then
            anim:setPriority(priority)
        end
    end
end

function safeAnim.getPriorityIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPriority()
        end
    end
end

function safeAnim.setTimeIfExists(model, name, time)
    if model then
        local anim = model[name]
        if anim then
            anim:setTime(time)
        end
    end
end

function safeAnim.getTimeIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getTime()
        end
    end
end

function safeAnim.setOffsetIfExists(model, name, offset)
    if model then
        local anim = model[name]
        if anim then
            anim:setOffset(offset)
        end
    end
end

function safeAnim.getOffsetIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOffset()
        end
    end
end

function safeAnim.setLoopIfExists(model, name, loop)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoop(loop)
        end
    end
end

function safeAnim.getLoopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoop()
        end
    end
end

function safeAnim.setBlendIfExists(model, name, blend)
    if model then
        local anim = model[name]
        if anim then
            anim:setBlend(blend)
        end
    end
end

function safeAnim.getBlendIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getBlend()
        end
    end
end

function safeAnim.setStartDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setStartDelay(delay)
        end
    end
end

function safeAnim.getStartDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getStartDelay()
        end
    end
end

function safeAnim.setLoopDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoopDelay(delay)
        end
    end
end

function safeAnim.getLoopDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoopDelay()
        end
    end
end

-- Override
function safeAnim.setOverrideIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverride(override)
        end
    end
end

function safeAnim.setOverrideRotIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideRot(override)
        end
    end
end

function safeAnim.getOverrideRotIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideRot()
        end
    end
end

function safeAnim.setOverridePosIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverridePos(override)
        end
    end
end

function safeAnim.getOverridePosIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverridePos()
        end
    end
end

function safeAnim.setOverrideScaleIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideScale(override)
        end
    end
end

function safeAnim.getOverrideScaleIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideScale()
        end
    end
end

-- safeAnimisc
function safeAnim.getNameIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getName()
        end
    end
end

function safeAnim.newCodeIfExists(model, name, time, code)
    if model then
        local anim = model[name]
        if anim then
            anim:newCode(time, code)
        end
    end
end

return safeAnim