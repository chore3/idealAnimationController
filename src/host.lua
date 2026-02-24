local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local tglUnexpected = mainPage:newAction()
    :title("unexpected")
    :item("minecraft:gray_dye")
    :toggleItem("minecraft:lime_dye")
tglUnexpected:setOnToggle(function () customStates.unexpected = tglUnexpected:isToggled() end)

