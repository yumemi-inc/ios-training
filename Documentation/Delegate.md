# 非同期APIを利用する
`YumemiWeather`の非同期APIを利用して、天気予報を取得してみましょう。

`static func asyncFetchWeather(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void)`  
[APIの概要](YumemiWeather.md)


# Delegate

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

# 非同期APIの結果を受け取る Part.1
## 課題
- Delegateパターンを使い、非同期APIから天気予報を受け取る
- ViewControllerに`deinit`を実装し、ログを出力するようにしておく
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する