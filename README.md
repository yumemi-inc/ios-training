# iOS研修
業務に近いかたちでアプリ開発を行いながら、  
iOSアプリ開発の基礎復習、実務スキルを身に付けるための研修です。

## 概要
天気予報アプリを開発していただきます。  

## 環境
Xcode 11.4  
Swift 5.2

## 天気予報API
`YumemiWeather`というライブラリを使用してください。  
SwiftPackageManagerに対応しています。

インストール方法やAPI仕様は以下を参照ください。  
[YumemiWeather](Documentation/YumemiWeather.md)

## 研修の進め方
1. ご自身のGitHubアカウントで研修用のリポジトリを作成
1. 研修用リポジトリにXcodeProjectを作成  
1. XcodeProjectに[YumemiWeather](Documentation/YumemiWeather.md)を導入
1. `main`ブランチをPush
1. 課題用のブランチを切って実施  
`/session/{#}`
1. 完了したらPull Requestを作成し、レビュー依頼  
`main` <-- `session/{#}`
1. Approvalされたらマージ
1. 次の課題を実施

全ての改題をクリアしたら修了です！

### レビュー待ちのとき
レビュー待ちの時は次の課題に先行着手しましょう。  
`git rebase` コマンドを使ってみましょう。(注1)  
Session1がレビュー待ちの場合...
1. `session/1`ブランチから`session/2`を切る
1. Session2を進める
1. `session/1`のマージ後、`session/2`を`main`でrebaseする  


# 課題
- [Session1](Documentation/AutoLayout.md)
- [Session2](Documentation/API.md)
- [Session3](Documentation/Error.md)
- [Session4](Documentation/Json.md)
- [Session5](Documentation/Codable.md)
- [Session6](Documentation/VC_Lifecycle.md)
- [Session7](Documentation/NotificationCenter.md)
- [Session8](Documentation/UnitTest.md)
- [Session9](Documentation/ThreadBlock.md)
- [Session10](Documentation/Delegate.md)
- [Session11](Documentation/Closure.md)
- [Session12](Documentation/BugFix.md)
  
**(注1)**  
このようなケースで `rebase` コマンドを使うことが必ずしも正しいとは限りません。  
どのような方法をとるかはチームで議論するべきと考えます。  
ただ、この研修は「`rebase`コマンドを使ってみる」ことも研修の一部としています。
