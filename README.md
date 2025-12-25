# 導入方法
## Gist
従来通りの方法です。簡単に利用できます。

リンク先のスクリプトをコピーアンドペーストする。

https://gist.github.com/chore3/64d3f53f5efb5a4ac32baeb8006fb833

## Releases
または、以下の方法で利用できます。

1. [最新のリリース](https://github.com/chore3/idealAnimationController/releases/latest)からidealAnimationController.zipをダウンロードする
1. ダウンロードしたzipファイルの中身を、アバターのディレクトリにドラッグアンドドロップする

Gistとは異なり、メインのプログラムファイルが短く書かれているため、こちらの方法でダウンロードしたほうがコードが読みやすいと思います。また、おそらくバグ修正や機能追加はこちらの配布方法の方が活発になります

# 利用方法
## 再生可能なアニメーションの種類
以下の名称で作成されたアニメーションは適切なタイミングで再生されます。
また、アニメーションが存在しない場合、そのアニメーションは無視されます。
| 名称 | 説明 |　推奨ループモード |
| --- | :-- | --- |
| `jump` | ジャンプした瞬間に再生されます | １回のみ |
| `land` | 着地モーションです。高所から着地した際に再生されます。再生中に歩き始めると解除されます。 | １回のみ |
| `block` | 盾を構えているときに再生されます | ループ |
| `swim` | 泳いでいるときに再生されます | ループ |
| `glide` | エリトラで滑空しているときに再生されます | ループ |
| `crouch` | スニークしているときに再生されます | ループ |
| `climb` | ツタや梯子を上っているときに再生されます | ループ |
| `sprint` | 走っているときに再生されます | ループ |
| `walk` | 歩いているときに再生されます | ループ |
| `idle` | 何もせず立っているときに再生されます | ループ |
| `fall` | 落下中に再生されます | ループ |

---

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
