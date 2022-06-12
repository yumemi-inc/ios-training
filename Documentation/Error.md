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
  メッセージの内容は自由です。エラーを切り分けられていればOK。
