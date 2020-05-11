# コールバック

完了時の処理を引数で渡しておく手法があります。  
UIViewControllerの [present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present)

Delegateパターンよりも全体の処理の流れが追いやすくなると思います。  
また、メソッドが1〜2つのDelegateですと、コールバックを用いた方が実装量も少なくなるでしょう。  
反対に、Modelが要求するコールバックが多いと、Delegateパターンを用いて一つの型にまとめた方が管理し易い場合もあるでしょう。

## 課題
- Modelの天気予報取得メソッドに、結果を通知する関数型引数を追加する
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する

ぜひ関数型引数はOptional型、非Optional型の両方を実装し、その違いを確認してみましょう。