# 📦導入方法
## Releases

1. [最新のリリース](https://github.com/chore3/idealAnimationController/releases/latest)から`idealAnimationController.zip`をダウンロード
1. zipファイルを解凍する
1. `modules`, `src`, `avatar.json`をアバターのフォルダにドラッグアンドドロップ

---

# 🔍クイックスタート
`avatar.json`のautoScriptsを`script`から`examples/script`に書き換えることで実装例を見ながら動作を確認することができます。

```JSON
{
  "name": "dev",
  "description": "",
  "authors": [
    "chore_3"
  ],
  "color": "#f8c53a",
  "autoScripts": [
    "examples/script"
  ]
}
```

---

# 📌機能
## アニメーションの自動再生
デフォルトのプログラムではBlockbench内で以下の名称で作成したアニメーションが「状態」の変化に合わせて自動的に再生されます。
| 名称 | 説明 | 排他的 | 優先度 | 推奨ループモード |
| :-- | :-- | :-: | :-- | :-- |
| `idle` | 何もせずに立っているときに再生されます | ○ | 0 | ループ |
| `fishing` | 釣り竿を使用して釣りをしている間に再生されます | ○ | 1 | ループ |
| `sprint` | ダッシュしているときに再生されます | ○ | 2 | ループ |
| `walk` | 歩いているときに再生されます | ○ | 3 | ループ |
| `crouch` | しゃがみ（スニーク）状態のときに再生されます | ○ | 4 | ループ |
| `swim` | 泳いでいるときに再生されます | ○ | 5 | ループ |
| `climb` | はしごやツタなどを登っているときに再生されます | ○ | 6 | ループ |
| `fall` | 落下している最中に再生されます | ○ | 7 | ループ |
| `glide` | エリトラで滑空しているときに再生されます | ○ | 8 | ループ |
| `riptide` | 激流効果で高速移動しているときに再生されます | ○ | 9 | ループ |
| `sleep` | ベッドで横になっているときに再生されます | ○ | 10 | ループ |
| `die` | 死亡時に再生されます | ○ | 11 | ループ |
| `onJump` | ジャンプしたときに再生されます | × | - | 一回のみ |

複数の「排他的」なアニメーションが再生されるべき状態にある場合、最も優先度の高い1つのみが再生されます。

例えば、プレイヤーが「釣り」をしながら「走っている」場合、アニメーション`sprint`と`fishing`の両方が再生される条件を満たしますが、デフォルト状態では`fishing`よりも`sprint`の方が優先度が高いため`sprint`のみが再生されます。

<br>

排他的なアニメーションは`script.lua`内の`exclusiveAnimationsMap`を編集することで変更できます。いくつか変更例を見てみましょう。クリエイティブモードの飛行時のみ異なるアニメーションを再生する場合は`flying`を追加します。
```lua
local exclusiveAnimationsMap = {
    idle = 0,
    fishing = 1,
    sprint = 2,
    walk = 3,
    crouch = 4,
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
`idle`, `fishing`そして`flying`のように事前に定義されている「状態」は`stateHandler`というモジュールで管理されています。すべての「状態」については「モジュール/stateHandler」を参照してください。

<br>

また、stateHandlerモジュールで管理していない独自の「状態」を追加することもできます。独自の状態を利用するには、`customStates`に新たな「状態」を追記してください。`customStates`に入力した状態はstateHandlerモジュールで管理している「状態」と同様に`exclusiveAnimationsMap`に名称と優先度を入力することで自動再生できます。

例えば、`newExclusiveAnimation`を新たに排他的なアニメーションとして追加する場合、以下のようにします。
```lua
local exclusiveAnimationsMap = {
    idle = 0,
    fishing = 1,
    sprint = 2,
    walk = 3,
    crouch = 4,
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

</br>

## イベントハンドラ
stateHandlerモジュールで管理している「状態」が真(true)に変化したタイミングで実行されるコールバック関数です。イベントハンドラはすべて次の命名規則に従います。

```lua
stateHandler.on<状態名>
```

**イベントハンドラの例：**
- onJump
- onSprint
- onInventory

例えば、デフォルトのプログラムでは、プレイヤーがジャンプした瞬間にだけ`onJump`というアニメーションを再生するために、以下のようなイベントハンドラを利用しています。

```lua
stateHandler.onJump(function()
    safeAnim.setPlayIfExists(animations.model, "onJump", true)
end)
```

すべてのイベントハンドラについては「モジュール/stateHandler」を参照してください。

---

# 🛠️モジュール
このプロジェクトでは、処理を分かりやすく整理するために機能ごとに分けた「モジュール」を使用しています。
## stateHandler
stateHandlerは、Host/Client間を同期しながらプレイヤーの状態を管理、保持するモジュールです。また、このモジュールは状態遷移に基づくイベント処理を提供します。

</br>

このモジュールは以下のようにして読み込むことができます。
```lua
stateHandler = require("modules/stateHandler")
```

stateHandlerは以下の状態を保持します。

| 状態名 | 状態取得関数 | イベントハンドラ | 説明 |
| :-- | :-- | :-- | :-- |
| `idle` | `isIdle()` | `onIdle()` | 他のすべての状態が `false` のときに自動的に `true` になる待機状態 |
| `walk` | `isWalk()` | `onWalk()` | `sprint` ではないが、地上またはクリエ飛行中に移動している状態 |
| `crouch` | `isCrouch()` | `onCrouch()` | スニーク状態 |
| `sprint` | `isSprint()` | `onSprint()` | 地上またはクリエ飛行中に走っている状態 |
| `jump` | `isJump()` | `onJump()` | ジャンプ動作中 |
| `fall` | `isFall()` | `onFall()` | 空中にいて、下降速度が一定以上ある状態 |
| `swim` | `isSwim()` | `onSwim()` | 泳ぎ姿勢の状態 |
| `climb` | `isClimb()` | `onClimb()` | はしご・ツタなどを登っている状態 |
| `glide` | `isGlide()` | `onGlide()` | エリトラ滑空中 |
| `flying` | `isFlying()` | `onFlying()` | クリエイティブ飛行中 |
| `block` | `isBlock()` | `onBlock()` | 盾で防御している状態 |
| `chat` | `isChat()` | `onChat()` | チャット画面を開いている状態 |
| `inventory` | `isInventory()` | `onInventory()` | 何かしらのインベントリを開いている状態 |
| `inRain` | `isInRain()` | `onInRain()` | 雨に当たっている状態 |
| `burn` | `isBurn()` | `onBurn()` | 燃えている状態 |
| `fishing` | `isFishing()` | `onFishing()` | 釣り竿を使用しているとき |
| `eat` | `isEat()` | `onEat()` | 食べ物を使用中の状態 |
| `drink` | `isDrink()` | `onDrink()` | 飲み物を使用中の状態 |
| `riptide` | `isRiptide()` | `onRiptide()` | トライデントの激流エンチャントで回転移動中 |
| `sleep` | `isSleep()` | `onSleep()` | ベッドで寝ている状態 |
| `die` | `isDie()` | `onDie()` | 死亡アニメーション中 |
| `glow` | `isGlow()` | `onGlow()` | 発光エフェクトが付与されている状態 |

状態取得関数は現在の「状態」を返す関数です。
```lua
stateHandler.isWalk()
```

また、このモジュールは `stateHandler.states` というテーブルを提供します。このテーブルを使うと現在の状態を外部から参照できます。`stateHandler.states`は、内部で管理されている値のコピーであるためこのテーブルを直接変更しても内部状態には一切影響しません。

このテーブルの各要素は、対応する状態取得関数と同じ値を返します。例えば、`stateHandler.states.walk`と`stateHandler.isWalk()`は常に同じ結果を返します。

</br>

イベントハンドラは「状態」が真(true)に変化したタイミングで実行されるコールバック関数です。以下の実装例のように引数として関数を渡すことでイベントの発火時に任意の関数を実行できます。

```lua
stateHandler.onJump(function()
    safeAnim.setPlayIfExists(animations.model, "onJump", true)
end)
```

---

## safeAnim
指定したアニメーションが存在する場合にのみ再生を試みるAnimationのラッパー関数を提供するモジュールです。FiguraMODのAnimation APIの代わりに利用することで存在しないアニメーション参照した場合に起こるエラーを防ぐことができます。

提供する関数はAnimation APIとほとんど変わらないため、すべての関数についてのwikiは用意していません。Figura MODのAnimationについては、
https://figura-wiki.pages.dev/globals/Animations/Animation
を参照してください。

</br>

このモジュールは以下のようにして読み込むことができます。
```lua
safeAnim = require("modules/safeAnim")
```

</br>

### `isExists()`
アニメーションが存在するかどうかを確認します。
```lua
isExists(model, name)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `model` | [Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | アニメーションを再生したいモデルまでのパス |
| `name` | [String](https://figura-wiki.pages.dev/tutorials/types/Strings) | 再生したいアニメーション名 |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
| [Boolean](https://figura-wiki.pages.dev/tutorials/types/Booleans) | - |

**使用例:**
`myModel.animation == myAnim`である場合、
```lua
safeAnim.isExists(myModel, "animation")
```

---

### `playIfExists()`
アニメーションを再生します。一時停止されていた場合、アニメーションを再開します。
[play()](https://figura-wiki.pages.dev/globals/Animations/Animation#play) のラッパー関数です。
```lua
playIfExists(model, name)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `model` | [Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | アニメーションを再生したいモデルまでのパス |
| `name` | [String](https://figura-wiki.pages.dev/tutorials/types/Strings) | 再生したいアニメーション名 |

**戻り値:**
[play()](https://figura-wiki.pages.dev/globals/Animations/Animation#play) と同じ

**使用例:**
`myModel.animation == myAnim`である場合、
```lua
safeAnim.restartIfExists(myModel, "walk")
```

---

### `setPlayIfExists()`
アニメーションを再生します。一時停止されていた場合、アニメーションを再開します。
[setPlaying()](https://figura-wiki.pages.dev/globals/Animations/Animation#setPlaying) のラッパー関数です。
```lua
setPlayIfExists(model, name)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `model` | [Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | アニメーションを再生したいモデルまでのパス |
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

---

## util
汎用的な関数を提供します。

</br>

このモジュールは以下のようにして読み込むことができます。
```lua
util = require("modules/util")
```

</br>

### `countChildren()`
`root`が持つ子の数を返します。
```lua
countChildren(root)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `root` | [Models](https://figura-wiki.pages.dev/globals/Models) | モデルツリー内のノード |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
| [Integer](https://figura-wiki.pages.dev/tutorials/Types/Numbers) | - |

---

### `showModelPartAtIndex()`
`root`が持つ`index`番目の子を表示します。
```lua
showModelPartAtIndex(root, index)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `root` | [Models](https://figura-wiki.pages.dev/globals/Models) | モデルツリー内のノード |
| `index` | [Numbers](https://figura-wiki.pages.dev/tutorials/Types/Numbers) | 表示する子のインデックス |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
| [Boolean](https://figura-wiki.pages.dev/tutorials/types/Booleans) | 表示が成功したか |

---

### `hideAllChildren()`
`root`が持つすべての子ノードを非表示にします。
```lua
hideAllChildren(root)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `root` | [Models](https://figura-wiki.pages.dev/globals/Models) | モデルツリー内のノード |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
| [Integer](https://figura-wiki.pages.dev/tutorials/Types/Numbers) | 非表示にした子ノードの個数 |

**使用例:**
```lua
hats = models.model.root.Head.Hats
local currHat = 1
pings.changeHat(currHat)

local maxHat = util.countChildren(hats)

local hatAction = mainPage:newAction()
    :title(string.format("選択中の帽子[%d]", currHat))
    :item("minecraft:compass")
hatAction:setOnLeftClick(function()
    currHat = currHat + 1

    if maxHat < currHat then
        currHat = 0
    elseif currHat < 0 then
        currHat = maxHat
    end

    pings.changeHat(currHat)
    hatAction:setTitle(string.format("選択中の帽子[%d]", currHat))
end)

function pings.changeHat(state)
    util.hideAllChildren(hats)
    util.showModelPartAtIndex(hats, state)
    vanilla_model.HELMET:setVisible(state == 0)
    both.currHat = state
end
```

---

### `mergeTable()`
二つのテーブルを統合します。
```lua
mergeTable(t1, t2)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `t1` | [Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | - |
| `t2` | [Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | - |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
[Table](https://figura-wiki.pages.dev/tutorials/Types/Tables) | - |

---

### `randomBoxPos()`
指定した範囲内のランダムな3次元座標を返します。
```lua
randomBoxPos(min, max)
```
**引数:**
| 名称 | 型 |　説明 |
| --- | -- | :--- |
| `min` | [Numbers](https://figura-wiki.pages.dev/tutorials/Types/Numbers) | X, Y, Z座標の最小範囲 |
| `max` | [Numbers](https://figura-wiki.pages.dev/tutorials/Types/Numbers) | X, Y, Z座標の最大範囲 |

**戻り値:**
| 型 |　説明 |
| --- | :--- |
[Vector3](https://figura-wiki.pages.dev/globals/Vectors/Vector3) | - |

**使用例:**
```lua
local randomPos = util.randomBoxPos(-0.02, 0.02):add(0, -0.1, 0)
particles:newParticle("flame", models.model.root.Body.Jetpack.leftEngine:partToWorldMatrix():apply():add(randomPos)):setVelocity(0, -0.1, 0):setLifetime(5)
```

---

# ⚖️ライセンス
see [LICENCE](./LICENCE.md).
> [LICENCE](./LICENCE.md)をご確認ください。
