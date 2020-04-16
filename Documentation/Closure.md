# Delegateは相互に依存が発生する

Delegateパターンで結果を取得すると、  
ViewControllerとModelの間に相互に依存がうまれたと思います。

ModelはViewControllerに依存しないように修正してみましょう。  
Modelの天気予報取得メソッドに、結果を通知する関数型引数を追加してみましょう。

UIViewControllerの [present(_:animated:completion:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621380-present)メソッドのように、  
完了時の処理を引数で予め渡しておく手法です。

## 課題
- Modelの天気予報取得メソッドに、結果を通知する関数型引数を追加する
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する

ぜひ関数型引数はOptional型、非Optional型の両方を実装し、その違いを確認してみましょう。