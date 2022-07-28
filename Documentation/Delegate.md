# Delegateパターン

iOSアプリを開発しているとAppDelegateやUITableViewDelegateなど、  
`Delegate`というワードを良く目にすると思います。
日本語では`委譲`と呼ばれます。

Cocoa frameworkでも古くから採用されてきたパターンの一つです。

例えば、UITableViewのCell選択をトリガーに何か処理をしたいとします。  
どのCellを選択されたかはUITableViewしか知ることができません。  
なので、Cell選択をトリガーにした処理を実装するにはUITableViewを継承する。。。？  
そこで、Delegateです。  
UITableViewDelegateはProtocolで、Cellが選択されたときの関数が宣言されています。  
UITableViewはUITableViewDelegateの実装クラスを保持し、必要な時にDelegateの関数を呼び出します。

## 課題
- Delegateパターンを使い、APIから天気予報を受け取る
- ViewControllerに`deinit`を実装し、ログを出力するようにしておく
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する