# APIのエラーハンドリング
`YumemiWeather`のAPIがエラーをthrowしたときの実装をしましょう。

Throws ver  
`static func fetchWeatherCondition(at area: String) throws -> String`  
[APIの概要](YumemiWeather.md)

エラーが発生したときにどのように実装するか...  
Swiftにはベースになる考え方があります。  
実装が終わったら、ぜひ読んでください。  
[Swiftのエラー4分類が素晴らしすぎるのでみんなに知ってほしい](https://qiita.com/koher/items/a7a12e7e18d2bb7d8c77)  

## 課題
- 呼び出しAPIを`Throws ver`に変更する
- 天気予報を画面に表示する
- APIエラーが発生したらUIAlertControllerを表示する
  - エラーの内容に応じてメッセージを変更する  
  - メッセージの内容は自由ですが、[ヒューマンインターフェイスガイドラインのアラート](https://developer.apple.com/jp/design/human-interface-guidelines/alerts)の項目も読んで適切なエラーメッセージを考えてみましょう。エラーメッセージについては次の記事もあわせて読むとよりイメージが膨らむと思います
    - [本当に有意義なエラーメッセージを書くには](https://postd.cc/how-to-write-an-error-message/)
  - アラートの表現に関して、 [ヒューマンインターフェイスガイドラインのモダリティ](https://developer.apple.com/jp/design/human-interface-guidelines/modality)の項目も読んで適切に利用できるようにしましょう

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/0b948552bd89415c95e89e3ebe3811d6)
