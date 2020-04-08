# 各 Session における Tasks の洗い出し

「全てにチェックが付いたら Pull Request ができる」という条件を自身に付与する。

## Session 1 : `AutoLayout`
- [x] `UIImageView` の幅は `UIViewController` の幅の半分
  - `UIViewController` というよりも、`View` そのものに対する制約になっているが大丈夫か？
- [x] 青字の `UILabel` と赤字の `UILabel` の幅は `UIImageView` の半分
- [x] `UIImageView` の高さと幅は同じ
- [x] `UIImageView` と `UILabel` の隙間はあけない
  - `StackView` により実装した
- [x] `UIImageView` の水平中央は `UIViewController` の中央と同じ
- [x] `UIImageView` と `UILabel` を合わせた矩形の垂直中央は `UIViewController` の中央と同じ
  - `StackView` により実装した
- [x] `UIButton` と `UILabel` の隙間は `80pt`
- [x] `UIButton` と `UILabel` の水平中央は同じ

以上、8 項目

## Session 2 : 天気予報を取得して表示する
- [x] ボタンをタップして天気予報を取得する
- [x] 天気予報を画面に表示する
  - [x] 天気 (文字 or 画像)
  - [x] 最低気温
  - [x] 最高気温
- [x] API エラーが発生したら `UIAlertControler` を表示する

以上、6 項目

### Session 2 : Review
- [x] 天気アイコンを vector で
  - [x] Resizing : Preserve Vector Data
  - [x] Scales : Single Scale
- [x] `InputJSON` を別ファイルに
- [x] `weatherImageName` はプロパティである必要なし
- [x] WeatherVC L:58 想定外はエラーとして処理
- [ ] `errorTitleString` は `let` で記述できる
- [x] `encoding error` をログで出すだけでなく、きちんとハンドルする
  - [参考](https://qiita.com/koher/items/a7a12e7e18d2bb7d8c77)
- [ ] ライブラリのエラーをアプリで throw する (今回は Result だが) は混乱しやすいので避ける
- [ ] 改行の統一
- [x] 色の管理を ColorAssets で
  - [x] [参考](https://dev.classmethod.jp/articles/xcode-9-asset-catalogs-support-named-colors/)

## Session 6 : UIViewControllerのライフサイクル
(Session 3, 4, 5 は旧 Session 2 が分割されたため、飛ばして Sssion 6 に取り掛かる)
- [x] 新しい `ViewController` を追加する
- [x] アプリケーション起動時に新しい `ViewController` に遷移する
- [x] 新しい `ViewController` が表示されたら、前回まで作った `ViewController` に遷移する
- [x] 前回まで作った `ViewController` の `Close` ボタンを押下したら `ViewController` を閉じるようにする
