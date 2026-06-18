local physicsObjects = {}

local util = require("modules/util")
local spawned = {}
local nextId = 1

local CONTAINER_NAME = "physicsObjectsContainer"
local container

local function ensureContainer()
    if container then return container end
    container = models[CONTAINER_NAME] or models:newPart(CONTAINER_NAME)
    container:setParentType("WORLD")
    container:setVisible(true)
    return container
end

function physicsObjects.probeNextBlock(obj, dir)
    local nextPos = obj.position + dir
    local block   = world.getBlockState(nextPos)
    return block:hasCollision(), block
end

function physicsObjects.new(config)
    local parent = ensureContainer()
    config.model:setVisible(false)

    local id = nextId
    nextId = nextId + 1

    local part = config.model:copy("physicsObject_" .. id)
    part:setVisible(true)
    parent:addChild(part)

    local obj = {
        id = id,
        alive = true,
        age = 0,
        position = config.position or vec(0, 0, 0),
        velocity = config.velocity or vec(0, 0, 0),
        part = part,
        tickFn = config.tick,
    }

    function obj:destroy()
        self.alive = false
        self.part:remove()
    end

    part:setPos(util.worldToModelPos(obj.position))

    if config.init then
        config.init(obj)
    end

    spawned[#spawned + 1] = obj
    return obj
end

local function tickAll()
    local i = 1
    while i <= #spawned do
        local obj = spawned[i]
        if obj.alive then
            obj.age = obj.age + 1
            if obj.tickFn then
                obj.tickFn(obj)
            end
        end
        if not obj.alive then
            table.remove(spawned, i)
        else
            i = i + 1
        end
    end
end

events.TICK:register(tickAll, "physicsObjects")

return physicsObjects
