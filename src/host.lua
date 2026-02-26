-- # Host
-- [host(アバターの所有者)側でのみ実行されるファイルです。]
-- [アクションホイールの実行はHost側でのみ行われます。]

-- ==================================================

-- 下記実装例を使うときは --[[ と ]] を削除してください。
--[[

local mainPage = action_wheel:newPage()
action_wheel:setPage(mainPage)

local action1 = mainPage:newAction()
    :title("newExclusiveAnimation")
    :item("minecraft:gray_dye")
    :toggleItem("minecraft:lime_dye")

action1:setOnToggle(function ()
    -- # クリックされたときの動作を記入
    -- 第三者にも状態を教えるためにはpingを利用する必要があります(https://figura-wiki.pages.dev/tutorials/Pings)

    -- pings.ping1(action1:isToggled())

    -- ※ このファイルはHost(アバターを着ている本人)でしか実行されないためpingの受信は(./both.luaやscript.lua)で行ってください。
end)

]]