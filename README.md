# 株式会社ゆめみ iOS研修

[![Test](https://github.com/yumemi-inc/ios-training/actions/workflows/test.yml/badge.svg)](https://github.com/yumemi-inc/ios-training/actions/workflows/test.yml)

業務に近いかたちでアプリ開発を行いながら、  
iOSアプリ開発の基礎復習、実務スキルを身に付けるための研修です。

## 概要
天気予報アプリを開発していただきます。  

## 環境
XcodeとSwiftは、基本的に最新の安定版を利用すること

## 天気予報API
`YumemiWeather`というライブラリを使用してください。  
SwiftPackageManagerに対応しています。

インストール方法やAPI仕様は以下を参照ください。  
[YumemiWeather](Documentation/YumemiWeather.md)

## 研修の進め方
1. 空白の研修用のリポジトリを作成
    1. organizationでレビュアーユーザグループを設定してある場合、該当organizationでリポジトリを作成するとレビュアー設定しやすいです。ゆめみの場合は [yumemi-training](https://github.com/yumemi-training) で作成します。
    1. 研修終了後にご自身のGitHubアカウントにリポジトリを移動して構いません。
1. 研修用リポジトリにXcodeProjectを作成  
1. XcodeProjectに[YumemiWeather](Documentation/YumemiWeather.md)を導入
1. `main`ブランチをPush
1. 課題用のブランチを切って実施  
`session/{#}`
1. 完了したらPull Requestを作成し、レビュー依頼  
`main` <-- `session/{#}`
1. Approvalされたらマージ
1. 次の課題を実施

全ての課題をクリアしたら修了です！

### レビュー待ちのとき
レビュー待ちの時は次の課題に先行着手しましょう。  
`git rebase` コマンドを使ってみましょう。[^git-rebase]  
Session1がレビュー待ちの場合...
1. `session/1`ブランチから`session/2`を切る
1. Session2を進める
1. `session/1`のマージ後、`session/2`を`main`でrebaseする  

# Session

**■ アプリを形にする**

1) [AutoLayout](Documentation/AutoLayout.md)
1) [API](Documentation/API.md)

**■ 実践練習**

3) [Error](Documentation/Error.md)
1) [JSON](Documentation/JSON.md)
1) [Codable](Documentation/Codable.md)

**■ アプリの高度な制御**

6) [Lifecycle](Documentation/VC_Lifecycle.md)
1) [NotificationCenter](Documentation/NotificationCenter.md)
1) [UnitTest](Documentation/UnitTest.md)

**■ 非同期処理**

9) [ThreadBlock](Documentation/ThreadBlock.md)
1) [Delegate](Documentation/Delegate.md)
1) [Callback](Documentation/Callback.md)
1) [Concurrency](Documentation/Concurrency.md)

**■ 定番の UI 表現 (UIKit)**

13) [UITableView](Documentation/UITableView.md)
1) [UINavigationController](Documentation/UINavigationController.md)

**■ 実力チェック**

15) [BugFix](Documentation/BugFix.md)

[^git-rebase]: このようなケースで `rebase` コマンドを使うことが必ずしも正しいとは限りません。 どのような方法をとるかはチームで議論するべきと考えます。 ただ、この研修は「`rebase`コマンドを使ってみる」ことも研修の一部としています。

## 補足事項
- ライブラリ・ツール群に制約はありません
- 後の課題に含まれる技術要素を先に取り入れてもOKです

## 附録

[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/iOS-e22f8a8ab59d4b43b039bc201b3ceaf3)
