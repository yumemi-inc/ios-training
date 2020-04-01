# 天気予報を取得し、表示する
`YumemiWeather`のAPIを使用して、天気予報を取得しましょう。  
`static func fetchWeather(_ jsonString: String) throws -> String`  
[APIの概要](Documentation/YumemiWeather.md)

## 課題
- ボタンをタップして天気予報を取得する
- 天気予報を画面に表示する
  - 天気 (文字でも画像でも)
  - 最低気温
  - 最高気温
- APIエラーが発生したらUIAlertControllerを表示する

※イメージ  
![session1](Images/session1.gif)