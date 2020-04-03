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
- 余力があれば、Jsonのエンコード、デコードのテストも書いてみましょう

## テストコードを書くためにリファクタリングする

テストコードを書く前提でプログラムの設計をしていないと、なかなかテストが書きづらいものです。  
もし、テストコードが書けなかったら次の例のようにコードをリファクタリングしてみましょう。  
※必ずこの通りにしなくてもOKです。最良の方法ではなく、シンプルな例の紹介です
1. WeatherModelというProtocolを定義する
1. WeatherModelには`天気予報を取得する`関数を宣言する
1. WeatherModelの実装クラスWeatherModelImplを定義suru
1. ViewControllerから`天気予報を取得する実装`を切り離し、WeatherModelImplにおく
1. ViewControllerはWeatherModelをプロパティとしてもつ
1. ViewControllerの`天気予報を取得する実装`をWeatherModelの関数呼び出しに置き換える
1. 外部からViewControllerにWeatherModelImplを渡す

テストでは任意の値を返すWeatherModelの実装クラスを用意しておき、  
ViewControllerにそれを渡してあげるとテストコードが書きやすくなるでしょう。

### Protocol

SwiftにはProtocolという機能があります。  
クラスを使わずに型を抽象的に扱うことができます。  
上の例ですとViewControllerはWeatherModelに**依存しています**。  
その依存先をProtocolで表現することで、テストの時は**一定の値を返す実装に置き換える**ことができるようになります。

#### Protocol-Oriented Programming  
一方で、SwiftにはProtocol指向という考え方があります。  
[Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)  
サンプルコードが古いですが、日本語の分かり易い資料として  
[Swiftにおけるプロトコル指向プログラミング](https://github.com/mixi-inc/iOSTraining/blob/master/Swift/pages/day4/2-3_protocol-oriented-programming.md)

IntやArrayなどの型もProtocolを用いて実装されています。  
`Conforms To`の項に採用されているProtocolが列挙されています。  
このProtocolを辿っていくのも面白いです。  
[Int](https://developer.apple.com/documentation/swift/int)  
[Array](https://developer.apple.com/documentation/swift/array)

今回の課題ではProtocol指向としての設計には及んでいないように、筆者は思います。  
Protocol指向についてここで詳細は述べませんが、ぜひ専門書など手にとってみてください。

### Dependency Injection

DIや依存性の注入などと呼ばれます。  
繰り返しますが、上の例ですとViewControllerはWeatherModelに**依存しています**。  
例えば、ViewControllerがWeatherModelImpl(実装クラス)を内部でインスタンス化したとすると...  
せっかくProtocolで宣言したのに、実装クラスへの依存が生まれます。  
しかし、外部から実装クラスを受け取るようにすると、ViewControllerはWeatherModel(Protocol)への依存しか持たず、その実装は意識しなくて良いことになります。  
テストが書きやすくなったり、外部の変更に強いプログラムになり易いです。

### モックライブラリ
任意の値を返す `WeatherModel`の実装クラスをいくつも用意するのは骨がおれます。  
そういったモックやスタブの実装をサポートしてくれるライブラリがいくつかあります。  
- [Cuckoo](https://github.com/Brightify/Cuckoo)
- [Mockolo](https://github.com/uber/mockolo)