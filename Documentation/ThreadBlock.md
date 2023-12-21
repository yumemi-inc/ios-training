# スレッドブロック

時間のかかる処理を扱ってみましょう。

Sync ver  
```swift
static func syncFetchWeather(_ jsonString: String) throws -> String
```
[APIの概要](YumemiWeather.md)  

## 課題
- 呼び出しAPIを`Sync ver`に変更する
- APIの処理が戻るまで[UIActivityIndicatorView](https://developer.apple.com/documentation/uikit/uiactivityindicatorview)を表示する
- 非同期テストに書き換える
  - [Asynchronous Tests and Expectations](https://developer.apple.com/documentation/xctest/asynchronous_tests_and_expectations)

※イメージ  
![thread block](Images/ThreadBlock.gif)

## ヒント
iOSアプリで時間のかかる処理をするのにどうしたら良いかわからなかったり、何が問題になるのかのヒントを示しておきます。

- [iOSアプリで時間のかかる処理をする](https://zenn.dev/yumemi_inc/articles/ios-ui-thread)

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/b7b5ae4ba0074668acee26de28679ea2)
