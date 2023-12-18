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

### AppleのDocument
- [Using Delegates to Customize Object Behavior](https://developer.apple.com/documentation/swift/using-delegates-to-customize-object-behavior)
- [Delegation(Documentation Archive)](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html)

## 課題
- Delegateパターンを使い、APIの結果を受け取る
- ViewControllerに`deinit`を実装し、ログを出力するようにしておく
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する

## ヒント
- 結果を受け取る Delegate の例としては、位置情報をリクエストして結果を受け取る [CLLocationManager](https://developer.apple.com/documentation/corelocation/cllocationmanager) と [CLLocationManagerDelegate](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate) の関係が今回のやりたいことのイメージに近いです
- [func requestLocation()](https://developer.apple.com/documentation/corelocation/cllocationmanager/1620548-requestlocation) で位置情報をリクエストし、位置情報の更新が発生したら [func locationManager(CLLocationManager, didUpdateLocations: [CLLocation])](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate/1423615-locationmanager) で更新された位置情報を受け取ることができます
- これを今回の課題に置き換えると、天気予報をリクエストし、天気予報の更新が発生したら、更新された天気予報を受け取る、とすると実装をイメージがつかみやすいと思います

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/9a80a2dce3374ac68f67980ed633c038)
