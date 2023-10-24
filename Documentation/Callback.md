# コールバック

完了時の処理を引数で渡しておく手法があります。  
例えば、UIViewControllerの [present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present) など。

Delegateパターンよりも全体の処理の流れが追いやすくなると思います。  
また、メソッドが1〜2つのDelegateですと、コールバックを用いた方が実装量も少なくなるでしょう。  
反対に、Modelが要求するコールバックが多いと、Delegateパターンを用いて一つの型にまとめた方が管理し易い場合もあるでしょう。

## 課題
- Delegateで受け取っていたAPIの結果を、コールバック形式で受け取るように変更する
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する

ぜひ関数型引数はOptional型、非Optional型の両方を実装し、その違いを確認してみましょう。

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/e0054fb6f23e4e18a1720f363af65373)
