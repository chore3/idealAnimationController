# 📦導入方法
## Releases

1. [最新のリリース](https://github.com/chore3/idealAnimationController/releases/latest)から`idealAnimationController.zip`をダウンロード
1. zipファイルを解凍する
1. `modules`, `src`, `avatar.json`をアバターのフォルダにドラッグアンドドロップ

---

# 📌機能
## アニメーションの自動再生
以下の名称で作成されたアニメーションは適切なタイミングで自動再生されます。
排他的なアニメーションは最も優先度の高い1つのみが再生されます。

| 名称 | 説明 | 排他的 | 優先度 | 推奨ループモード |
| :-- | :-- | :-: | :-- | :-- |
| `idle` | 何もせずに立っているときに再生されます | ○ | 0 | ループ |
| `fishing` | 釣り竿を使用して釣りをしている間に再生されます | ○ | 1 | ループ |
| `walk` | 歩いているときに再生されます | ○ | 2 | ループ |
| `crouch` | しゃがみ（スニーク）状態のときに再生されます | ○ | 3 | ループ |
| `sprint` | ダッシュしているときに再生されます | ○ | 4 | ループ |
| `swim` | 泳いでいるときに再生されます | ○ | 5 | ループ |
| `climb` | はしごやツタなどを登っているときに再生されます | ○ | 6 | ループ |
| `fall` | 落下している最中に再生されます | ○ | 7 | ループ |
| `glide` | エリトラで滑空しているときに再生されます | ○ | 8 | ループ |
| `riptide` | 激流効果で高速移動しているときに再生されます | ○ | 9 | ループ |
| `sleep` | ベッドで横になっているときに再生されます | ○ | 10 | ループ |
| `die` | 死亡時に再生されます | ○ | 11 | ループ |
| `onJump` | ジャンプしたときに再生されます | × | - | 一回のみ |

排他的なアニメーションは`script.lua`内の`exclusiveAnimationsMap`を編集することで変更できます。
```
local exclusiveAnimationsMap = {
    idle = 0,
    fishing = 1,
    walk = 2,
    crouch = 3,
    sprint = 4,
    swim = 5,
    climb = 6,
    fall = 7,
    glide = 8,
    riptide = 9,
    sleep = 10,
    die = 11
}
```

## イベントハンドラ
プレイヤーの「状態」が変化した瞬間だけ実行される関数です。


---

# モジュール
## safeAnim
指定したアニメーションが存在する場合にのみ再生を試みるAnimationのラッパー関数です。FiguraMODのAnimationの代わりに利用することで存在しないアニメーション参照した場合に起こるエラーを防ぐことができます。

利用方法はほとんど変わらないため、すべての関数についてのwikiは用意していません。Figura MODのAnimationについては、
https://figura-wiki.pages.dev/globals/Animations/Animation
を参照してください。

---

### `playIfExists`
アニメーションを再生します。一時停止されていた場合、アニメーションを再開します。
[play()](https://figura-wiki.pages.dev/globals/Animations/Animation#play) のラッパー関数です。
```lua
playIfExists(model, name)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `model` | Table | アニメーションを再生したいモデルまでのパス |
| `name` | [String](https://figura-wiki.pages.dev/tutorials/types/Strings) | 再生したいアニメーション名 |

**戻り値:**
[play()](https://figura-wiki.pages.dev/globals/Animations/Animation#play) と同じ

**使用例:**
`myModel.animation == myAnim`である場合、
```lua
safeAnim.restartIfExists(myModel, "animation")
```

---

### `setPlayIfExists`
アニメーションを再生します。一時停止されていた場合、アニメーションを再開します。
[setPlaying()](https://figura-wiki.pages.dev/globals/Animations/Animation#setPlaying) のラッパー関数です。
```lua
setPlayIfExists(model, name)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `model` | Table | アニメーションを再生したいモデルまでのパス |
| `name` | [String](https://figura-wiki.pages.dev/tutorials/types/Strings) | 再生したいアニメーション名 |
| `bool` | [Boolean](https://figura-wiki.pages.dev/tutorials/types/Booleans) | trueの場合アニメーションを再生、falseの場合アニメーションを停止 |

**戻り値:**
[setPlaying()](https://figura-wiki.pages.dev/globals/Animations/Animation#setPlaying) と同じ

**使用例:**
`myModel.animation == myAnim`である場合、
```lua
-- This example would be in a function like a tick event
local crouching = player:getPose() == "CROUCHING"
safeAnim.setPlayIfExists(myModel, "animation", crouching)
```
