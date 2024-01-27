# アプリのテストコード

XcodeにはXCTestというテストフレームワークが備わっています。  
[Defining Test Cases and Test Methods](https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods)

XCTestを使ってアプリのテストコードを書いてみましょう

# テストを書いてみる
## 課題
- 次のテストコードを書いてみましょう
  - 天気予報が`sunny`だったら、画面に晴れ画像が表示されること
  - 天気予報が`cloudy`だったら、画面に曇り画像が表示されること
  - 天気予報が`rainy`だったら、画面に雨画像が表示されること
  - 天気予報の最高気温がUILabelに反映されること
  - 天気予報の最低気温がUILabelに反映されること
- 余力があれば、JSONのエンコード、デコードのテストも書いてみましょう

## テストコードを書くためにリファクタリングする

テストコードを書く前提でプログラムの設計をしていないと、なかなかテストが書きづらいものです。  
もし、テストコードが書けなかったら次の例のようにコードをリファクタリングしてみましょう。  
※必ずこの通りにしなくてもOKです。最良の方法ではなく、シンプルな例の紹介です
1. `WeatherFetching`というProtocolを定義する
1. `WeatherFetching`には**天気予報を取得する**関数を宣言する
1. `WeatherFetching`の実装クラス`WeatherProvider`を定義する
1. ViewControllerから**天気予報を取得する実装**を切り離し、`WeatherProvider`におく
1. ViewControllerは`WeatherFetching`をプロパティとしてもつ
1. ViewControllerの**天気予報を取得する実装**を`WeatherFetching`の関数呼び出しに置き換える
1. 外部からViewControllerに`WeatherProvider`を渡す

テストでは任意の値を返す`WeatherFetching`の実装クラスを用意しておき、  
ViewControllerにそれを渡してあげるとテストコードが書きやすくなるでしょう。

> [!NOTE]
> `WeatherFetching`や`WeatherProvider`は命名の一例です。
> Swift API Design Guideline で Naming についてガイドラインが示されているので読んでみてください
> 
> https://www.swift.org/documentation/api-design-guidelines/

### Protocol

SwiftにはProtocolという機能があります。  
クラスを使わずに型を抽象的に扱うことができます。  
上の例ですとViewControllerは`WeatherFetching`に**依存しています**。  
その依存先をProtocolで表現することで、テストの時は**一定の値を返す実装に置き換える**ことができるようになります。

#### Protocol-Oriented Programming  
一方で、SwiftにはProtocol指向という考え方があります。  
[Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)  
サンプルコードが古いですが、日本語の分かり易い資料として  
[Swiftにおけるプロトコル指向プログラミング](https://github.com/mixi-inc/iOSTraining/blob/master/Swift/pages/day4/2-3_protocol-oriented-programming.md)
[SwiftとProtocol指向](https://speakerdeck.com/lovee/swift-to-protocol-zhi-xiang)

IntやArrayなどの型もProtocolを用いて実装されています。  
`Conforms To`の項に採用されているProtocolが列挙されています。  
このProtocolを辿っていくのも面白いです。  
[Int](https://developer.apple.com/documentation/swift/int)  
[Array](https://developer.apple.com/documentation/swift/array)

今回の課題ではProtocol指向としての設計には及んでいないように、筆者は思います。  
Protocol指向についてここで詳細は述べませんが、ぜひ専門書など手にとってみてください。

### Dependency Injection

DIや依存性の注入などと呼ばれます。  
繰り返しますが、上の例ですとViewControllerは`WeatherFetching`に**依存しています**。  
例えば、ViewControllerが`WeatherProvider`(実装クラス)を内部でインスタンス化したとすると...  
せっかくProtocolで宣言したのに、実装クラスへの依存が生まれます。  
しかし、外部から実装クラスを受け取るようにすると、ViewControllerは`WeatherFetching`(Protocol)への依存しか持たず、その実装は意識しなくて良いことになります。  
テストが書きやすくなったり、外部の変更に強いプログラムになり易いです。

### モックライブラリ
任意の値を返す `WeatherFetching`の実装クラスをいくつも用意するのは骨がおれます。  
そういったモックやスタブの実装をサポートしてくれるライブラリがいくつかあります。  
- [Cuckoo](https://github.com/Brightify/Cuckoo)
- [Mockolo](https://github.com/uber/mockolo)

それがモックなのかスタブなのかについては以下の記事が詳しいです。

- [xUnit Test PatternsのTest Doubleパターン(Mock、Stub、Fake、Dummy等の定義)](https://goyoki.hatenablog.com/entry/20120301/1330608789)

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/d1d5655a68fd4d75a214d3b1a70b5c63)
