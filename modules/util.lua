local util = {}

local safeAnim = require("modules/safeAnim")

-- ==================================================

function util.countChildren(root)
    return #root:getChildren()
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

local function getStateValue(states, name)
    if states[name] ~= nil then
        return states[name]
    end
    return true
end

local function findPriorityStates(model, states, allowedSet)
    local maxPriority = -1
    local priorityStates = {}

    for name, priority in pairs(allowedSet) do
        local state = getStateValue(states, name)
        if priority and state and safeAnim.isExists(model, name) then
            if priority > maxPriority then
                maxPriority = priority
            end
            priorityStates[name] = priority
        end
    end

    local results = {}
    for name, priority in pairs(priorityStates) do
        if priority == maxPriority then
            table.insert(results, name)
        end
    end

    return results
end

function util.getHighestPriorityActivePlayableState(model, states, allowedSet)
    local results = findPriorityStates(model, states, allowedSet)
    return results[1] or nil
end

function util.getHighestPriorityActivePlayableStateList(model, states, allowedSet)
    local results = findPriorityStates(model, states, allowedSet)
    local topStateList = {}
    for _, name in ipairs(results) do
        table.insert(topStateList, name)
    end
    return topStateList
end

-- ==================================================

util.table = {}
function util.table.merge(t1, t2)
    local res = {}
    for k, v in pairs(t1) do res[k] = v end
    for k, v in pairs(t2) do res[k] = v end
    return res
end

function util.table.containsValue(t, value)
    for _, v in pairs(t) do
        if v == value then return true end
    end
    return false
end

function util.table.containsKey(t, key)
    return t[key] ~= nil
end

function util.randomBoxPos(min, max)
    local SCALE = 1000
    if max < min then
        buffer = max
        max = min
        min = buffer
    end
    min = min * SCALE
    max = max * SCALE
    if math.abs(min) < 0 or math.abs(max) < 0 then
        return nil
    end
    return vec(math.random(min, max) / SCALE, math.random(min, max) / SCALE, math.random(min, max) / SCALE)
end

function util.worldToModelPos(pos)
    return pos * 16
end

function worldToModelPos(pos)
    return pos * 16
end

function util.directionToModelMatrix(position, direction, roll)
    if not position or not direction or direction:length() == 0 then
        return nil
    end

    local forward = direction:normalized()
    local reference = math.abs(forward.y) > 0.999 and vec(0, 0, 1) or vec(0, 1, 0)

    local right = vec(forward.x, forward.y, forward.z):cross(reference):normalized()
    local up = vec(right.x, right.y, right.z):cross(forward):normalized()

    if roll and roll ~= 0 then
        local radians = math.rad(roll)
        local cosRoll = math.cos(radians)
        local sinRoll = math.sin(radians)
        local rolledRight = right * cosRoll + up * sinRoll
        local rolledUp = up * cosRoll - right * sinRoll
        right = rolledRight
        up = rolledUp
    end

    local modelPos = worldToModelPos(position)
    return matrices.mat4(
        vec(right.x, right.y, right.z, 0),
        vec(forward.x, forward.y, forward.z, 0),
        vec(up.x, up.y, up.z, 0),
        vec(modelPos.x, modelPos.y, modelPos.z, 1)
    )
end

function util.setPartDirFromUp(part, position, direction, roll)
    local matrix = util.directionToModelMatrix(position, direction, roll)
    if matrix then
        part:setMatrix(matrix)
    end
    return part
end

-- ==================================================

return util
