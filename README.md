# 📦導入方法
## Releases

1. [最新のリリース](https://github.com/chore3/idealAnimationController/releases/latest)から`idealAnimationController.zip`をダウンロード
1. zipファイルを解凍する
1. `modules`, `src`, `avatar.json`をアバターのフォルダにドラッグアンドドロップ

---

# 📌機能
## アニメーションの自動再生
デフォルト状態で自動再生されるアニメーションは以下の通りです。
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


複数の「排他的」なアニメーションが再生されるべき状態にある場合、最も優先度の高い1つのみが再生されます。

例えば、プレイヤーが「釣り」をしながら「走っている」場合、アニメーション`sprint`と`fishing`の両方が再生される条件を満たしますが、デフォルト状態では`fishing`よりも`sprint`の方が優先度が高いため`sprint`のみが再生されます。排他的なアニメーションは`script.lua`内の`exclusiveAnimationsMap`を編集することで変更できます。いくつか変更例を見てみましょう。

クリエイティブモードの飛行時のみ異なるアニメーションを再生する場合は`flying`を追加します。
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
    die = 11,

    flying = 12
}
```
`idle`, `fishing`そして`flying`のように事前に定義されている「状態」は`stateHandler`というモジュールで管理されています。すべての「状態」については次章を参照してください。

また、stateHandlerモジュールで管理していない独自の「状態」を追加することもできます。独自の状態を利用するには、`customStates`に新たな「状態」を追記してください。`customStates`に入力した状態はstateHandlerモジュールで管理している「状態」と同様に`exclusiveAnimationsMap`に名称と優先度を入力することで自動再生できます。

例えば、`newExclusiveAnimation`を新たに排他的なアニメーションとして追加する場合、以下のようにします。
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
    die = 11,

    newExclusiveAnimation = 100
}

_G.customStates = {
    newExclusiveAnimation = false
}
```
`newExclusiveAnimation`は100であり、これは他のどの「状態」よりも高い優先度であるため、アクションホイールなどで`customStates.newExclusiveAnimation = true`のようにして`newExclusiveAnimation`の状態を真(true)にした場合、常に`newExclusiveAnimation`という名称のアニメーションが再生されます。

## イベントハンドラ
stateHandlerモジュールで管理している「状態」が真(true)に変化した瞬間だけ実行されるコールバック関数です。イベントハンドラはすべて次の命名規則に従います。

```
stateHandler.on<状態名>
```

**イベントハンドラの例：**
- onJump
- onSprint
- onInventory

例えば、デフォルトのプログラムでは、プレイヤーがジャンプした瞬間にだけ`onJump`というアニメーションを再生するために、以下のようなイベントハンドラを利用しています。

```
stateHandler.onJump(function()
    safeAnim.setPlayIfExists(animations.model, "onJump", true)
end)
```

すべてのイベントハンドラについては次章を参照してください。

---

# 🛠️モジュール
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

# ⚖️ライセンス
see [LICENCE](./LICENCE.md).
> [LICENCE](./LICENCE.md)をご確認ください。