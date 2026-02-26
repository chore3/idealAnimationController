-- # stateEvents
-- [stateHandler.statesの値がtrueになった瞬間のみ実行される関数です。]
-- [script.lua内の`require("src/onStateEvent")`のコメントアウト(-- )を削除することで動作を確認できます。]

-- ==================================================

stateHandler.onJump(function()
    log("jump")
end)
