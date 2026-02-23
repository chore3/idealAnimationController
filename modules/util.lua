local util = {}

local safeAnim = require("modules/safeAnim")

-- ==================================================

function util.countChildren(root)
    local table = root:getChildren()
    local count = 0
    for i, item in ipairs(table) do
        count = count + 1
    end
    return count
end

function util.showModelPartAtIndex(root, index)
    local children = root:getChildren()
    if index < 1 or index > #children then
        return false
    end

    local target = children[index]
    local name = target:getName()
    if root[name] then
        root[name]:setVisible(true)
        return true
    end

    return false
end

function util.hideAllChildren(root)
    local table = root:getChildren()
    local count = 0
    for i, item in ipairs(table) do
        if root[item:getName()] then
            root[item:getName()]:setVisible(false)
            count = count + 1
        end
    end
    return count
end

-- ==================================================

function util.getUnexpectedAnimations(model, allowedSet)
    local diff = {}
    for _, anim in pairs(animations:getPlaying()) do
        local name = anim:getName()
        if model[name] and not allowedSet[name] then
            table.insert(diff, anim)
        end
    end
    return diff
end

function util.getHighestPriorityActiveState(states, allowedSet)
    local topState = nil
    local maxPriority = -1
    for name, isActive in pairs(states) do
        if isActive then
            local priority = allowedSet[name]
            if priority and priority > maxPriority then
                maxPriority = priority
                topState = name
            end
        end
    end
    return topState
end

-- ==================================================

return util