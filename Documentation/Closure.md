# Delegateは相互に依存が発生する

Delegateパターンで非同期APIの結果を取得すると、  
ViewControllerとModelの間に相互に依存がうまれたと思います。
ModelはViewControllerに依存しないよう、関数型プロパティでAPIの結果を通知してみましょう。

# APIを叩く別画面から結果を受け取る Part.2
## 課題
- ModelにAPI終了時に呼び出すcompletionプロパティを追加する
- ViewControllerはAPIの結果を受け取る処理をcompletionプロパティにセットする
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する