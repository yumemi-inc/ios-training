# Codable

多くのアプリでは外部APIとのやりとりが行われます。  
そして、多くの場合データの受け渡しはJsonやXMLが使われます。

SwiftにはJsonやXMLを扱うための便利な機能が標準ライブラリに備わっています。

[Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)

# APIのリクエスト&レスポンスをCodableで扱う
## 課題
- Codableの仕組みを利用して、`YumemiWeather`のAPIのパラメータを作成する
- Codableの仕組みを利用して、`YumemiWeather`のAPIの結果を扱う