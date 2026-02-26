-- # Host
-- [host(アバターの所有者)側でのみ実行されるファイルです。]
-- [アクションホイールの実行はHost側でのみ行われます。]

-- ==================================================

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

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
