local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

-- ==================================================

local tglNewExclusiveAnimation = mainPage:newAction()
    :title("newExclusiveAnimation")
    :item("minecraft:gray_dye")
    :toggleItem("minecraft:lime_dye")
tglNewExclusiveAnimation:setOnToggle(function () pings.tglNewExclusiveAnimation(tglNewExclusiveAnimation:isToggled()) end)

local tglHalo = mainPage:newAction()
    :title("tgl halo")
    :item("minecraft:gray_dye")
    :toggleItem("minecraft:lime_dye")
    :setToggled(true)
tglHalo:setOnToggle(function () pings.tglHalo(tglHalo:isToggled()) end)

local waveHand = mainPage:newAction()
    :title("wave hand")
    :item("minecraft:cookie")
    :setOnLeftClick(function () pings.waveHand() end)

local fireMissile = mainPage:newAction()
    :title("fire missile")
    :item("minecraft:fire_charge")
fireMissile:setOnLeftClick(function()
    local pos = player:getPos() + vec(0, 1.2, 0)
    local dir = player:getLookDir()
    pings.spawnExampleMissile(pos, dir)
end)
