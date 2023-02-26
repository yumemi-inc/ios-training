# コンカレンシー

iOS 15以降のSwiftランタイムはコンカレンシー（並行演算）をサポートし、またXcode 13.2以降ではこの機能をiOS 13までバックデプロイしました。
コンカレンシーを使うと、これまでのようにスレッドをブロックすることなく、あたかも同期的に処理が書けますが、内部的にはきちんと非同期に動きます。
例えば`URLSession`の[`data(from:delegate:)`](https://developer.apple.com/documentation/foundation/urlsession/3767353-data)などがこの機能を利用しています。

非同期処理にも関わらず、スレッドをブロックせずに同期的のようにコードが書けるので、コールバックを用いる方法よりも遥かに書きやすくなるでしょう。

## 課題
- Delegateで受け取っていたAPIの結果を、コンカレンシー形式で受け取るように変更する
- ViewControllerを閉じた時に`deinit`が呼ばれることを確認する

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/edb4d0bc62dd4a13b59f7415240bb460)
