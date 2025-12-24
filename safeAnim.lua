-- Play/Stop
function playIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:play()
        end
    end
end

function stopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:stop()
        end
    end
end

function pauseIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:pause()
        end
    end
end

function restartIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            anim:restart()
        end
    end
end

function setPlayIfExists(model, name, bool)
    if model then
        local anim = model[name]
        if anim then
            anim:setPlaying(bool)
        end
    end
end

function isExistsAndPlaying(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPlaying()
        end
    end
end


function isExistsAndStopped(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isStopped()
        end
    end
end

function isExistsAndPaused(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:isPaused()
        end
    end
end

function getPlayStateIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPlayState()
        end
    end
end

-- Timing
function setSpeedIfExists(model, name, speed)
    if model then
        local anim = model[name]
        if anim then
            anim:setSpeed(speed)
        end
    end
end

function getSpeedIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getSpeed()
        end
    end
end

function setLengthIfExists(model, name, length)
    if model then
        local anim = model[name]
        if anim then
            anim:setLength(length)
        end
    end
end

function getLengthIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLength()
        end
    end
end

function setPriorityIfExists(model, name, priority)
    if model then
        local anim = model[name]
        if anim then
            anim:setPriority(priority)
        end
    end
end

function getPriorityIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getPriority()
        end
    end
end

function setTimeIfExists(model, name, time)
    if model then
        local anim = model[name]
        if anim then
            anim:setTime(time)
        end
    end
end

function getTimeIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getTime()
        end
    end
end

function setOffsetIfExists(model, name, offset)
    if model then
        local anim = model[name]
        if anim then
            anim:setOffset(offset)
        end
    end
end

function getOffsetIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOffset()
        end
    end
end

function setLoopIfExists(model, name, loop)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoop(loop)
        end
    end
end

function getLoopIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoop()
        end
    end
end

function setBlendIfExists(model, name, blend)
    if model then
        local anim = model[name]
        if anim then
            anim:setBlend(blend)
        end
    end
end

function getBlendIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getBlend()
        end
    end
end

function setStartDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setStartDelay(delay)
        end
    end
end

function getStartDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getStartDelay()
        end
    end
end

function setLoopDelayIfExists(model, name, delay)
    if model then
        local anim = model[name]
        if anim then
            anim:setLoopDelay(delay)
        end
    end
end

function getLoopDelayIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getLoopDelay()
        end
    end
end

-- Override
function setOverrideIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverride(override)
        end
    end
end

function setOverrideRotIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideRot(override)
        end
    end
end

function getOverrideRotIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideRot()
        end
    end
end

function setOverridePosIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverridePos(override)
        end
    end
end

function getOverridePosIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverridePos()
        end
    end
end

function setOverrideScaleIfExists(model, name, override)
    if model then
        local anim = model[name]
        if anim then
            anim:setOverrideScale(override)
        end
    end
end

function getOverrideScaleIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getOverrideScale()
        end
    end
end

-- Misc
function getNameIfExists(model, name)
    if model then
        local anim = model[name]
        if anim then
            return anim:getName()
        end
    end
end

function newCodeIfExists(model, name, time, code)
    if model then
        local anim = model[name]
        if anim then
            anim:newCode(time, code)
        end
    end
end