-- 花火を利用した
local fireworkCount
function events.tick()
    local selectedItem = player:getHeldItem(false)
    if selectedItem:getID() == "minecraft:firework_rocket" then
        if fireworkCount ~= nil and fireworkCount ~= selectedItem:getCount() then
            log("firework used!!")
        end
        fireworkCount = selectedItem:getCount()
    else
        fireworkCount = nil
    end
end