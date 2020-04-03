# YumemiWeather
天気予報を取得する擬似APIです。

## インストール方法
SwiftPackageManagerに対応しています。

1. Xcodeプロジェクトを開く
1. File > Swift Packages > Add Package Dependency...
1. テキストフィールドに`git@github.com:yumemi/ios-training.git`を入力し、`Next`ボタンクリック
1. versionはそのままで`Next`ボタンクリック

# APIs

すべてのAPIはYumemiWeatherクラスに実装されています。

## Simple ver
同期的に天気予報を取得するAPIです。  
`public static func fetchWeather() -> String`

### Returns
天気を表す文字列 "sunny" or "cloudy" or "rainy"

## Throws ver
同期的に天気予報を取得するAPIです。  
ランダムにエラーが発生します。  
`static func fetchWeather(at area: String) throws -> String`

### Parameter
天気予報を取得する対象地域 example: "tokyo"

### Throws
YumemiWeatherError型

### Returns
天気を表す文字列 "sunny" or "cloudy" or "rainy"

## Json ver
同期的に天気予報を取得するAPIです。  
ランダムにエラーが発生します。  
`static func fetchWeather(_ jsonString: String) throws -> String`

### Parameter
Json文字列
|Key|型|フォーマット|例|
|:--|:--|:--|:--|
|area|String|自由|tokyo|
|date|String|yyyy-MM-dd'T'HH:mm:ssZZZZZ|2020-04-01T12:00:00+09:00|

### Throws
YumemiWeatherError型

### Returns
Json文字列
|Key|型|フォーマット|例|
|:--|:--|:--|:--|
|weather|String|sunny or cloudy or rainy|sunny|
|maxTemp|Int|--|20|
|minTemp|Int|--|-20|
|date|String|yyyy-MM-dd'T'HH:mm:ssZZZZZ|2020-04-01T12:00:00+09:00|

## Async ver
非同期に天気予報を取得するAPIです。  
ランダムにエラーが発生します。  
`static func fetchWeather(_ jsonString: String, completion: @escaping (Result<String, YumemiWeatherError>) -> Void)`

### Parameters
#### jsonString
Json文字列
|Key|型|フォーマット|例|
|:--|:--|:--|:--|
|area|String|自由|tokyo|
|data|String|yyyy-MM-dd'T'HH:mm:ssZZZZZ|2020-04-01T12:00:00+09:00|

#### completion
結果を受け取るコールバック  
`Result<String, YumemiWeatherError>`  
成功時の文字列は同期APIと同じ。

### Returns
Void

## Error type
YumemiWeatherError
```swift
public enum YumemiWeatherError: Swift.Error {
    case invalidParameterError
    case jsonDecodeError
    case unknownError
}
```