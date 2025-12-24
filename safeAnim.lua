local M = {}

-- Play/Stop
function M.playIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:play()
        end
    end
end

function M.stopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:stop()
        end
    end
end

function M.pauseIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:pause()
        end
    end
end

function M.restartIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:restart()
        end
    end
end

function M.setPlayIfExists(model, name, bool)
    if model then
        local anim = model[name]
        if anim then
            anim:setPlaying(bool)
        end
    end
end

function M.isExistsAndPlaying(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPlaying()
        end
    end
end


function M.isExistsAndStopped(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isStopped()
        end
    end
end

function M.isExistsAndPaused(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPaused()
        end
    end
end

function M.getPlayStateIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPlayState()
        end
    end
end

-- Timing
function M.setSpeedIfExists(model, name, speed)
    if model then
        local anim = model[name]
        if anim then
            anim:setSpeed(speed)
        end
    end
end

function M.getSpeedIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getSpeed()
        end
    end
end

function M.setLengthIfExists(model, name, length)
    if model then
        local anim = model[name]
        if anim then
            anim:setLength(length)
        end
    end
end

function M.getLengthIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLength()
        end
    end
end

function M.setPriorityIfExists(model, name, priority)
    if model then
        local anim = model[name]
        if anim then
            anim:setPriority(priority)
        end
    end
end

function M.getPriorityIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPriority()
        end
    end
end

function M.setTimeIfExists(model, name, time)
    if model then
        local anim = model[name]
        if anim then
            anim:setTime(time)
        end
    end
end

function M.getTimeIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getTime()
        end
    end
end

function M.setOffsetIfExists(model, name, offset)
    if model then
        local anim = model[name]
        if anim then
            anim:setOffset(offset)
        end
    end
end

function M.getOffsetIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOffset()
        end
    end
end

function M.setLoopIfExists(model, name, loop)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoop(loop)
        end
    end
end

function M.getLoopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoop()
        end
    end
end

function M.setBlendIfExists(model, name, blend)
    if model then
        local anim = model[name]
        if anim then
            anim:setBlend(blend)
        end
    end
end

function M.getBlendIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getBlend()
        end
    end
end

function M.setStartDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setStartDelay(delay)
        end
    end
end

function M.getStartDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getStartDelay()
        end
    end
end

function M.setLoopDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoopDelay(delay)
        end
    end
end

function M.getLoopDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoopDelay()
        end
    end
end

-- Override
function M.setOverrideIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverride(override)
        end
    end
end

function M.setOverrideRotIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideRot(override)
        end
    end
end

function M.getOverrideRotIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideRot()
        end
    end
end

function M.setOverridePosIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverridePos(override)
        end
    end
end

function M.getOverridePosIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverridePos()
        end
    end
end

function M.setOverrideScaleIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideScale(override)
        end
    end
end

function M.getOverrideScaleIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideScale()
        end
    end
end

-- Misc
function M.getNameIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getName()
        end
    end
end

function M.newCodeIfExists(model, name, time, code)
    if model then
        local anim = model[name]
        if anim then
            anim:newCode(time, code)
        end
    end
end

return M