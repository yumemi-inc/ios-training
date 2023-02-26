# UIViewControllerのライフサイクル

UIViewControllerのライフサイクルに関するリファレンスをまとめました。よく読んでみてください。  
各コールバック関数に`print`を入れて、動作を確認してみると良いです。

### Viewの生成、表示、非表示
[UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller)  
※`Handling View-Related Notifications`の項  

### レイアウト調整
[viewWillLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews)  
[viewDidLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621398-viewdidlayoutsubviews)

### 関連情報
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/407a7e666af74b80ba8692646d99803c)

## 課題
- `新しいViewController`を追加する
- アプリケーション起動時に`新しいViewController`に遷移する
- `新しいViewController`が表示されたら、前回まで作ったViewControllerに遷移する
- 前回まで作ったViewControllerのCloseボタンを押下したらViewControllerを閉じるようにする

※イメージ  
![VC_Lifecycle](Images/VC_Lifecycle.gif)

## 附録
[関連ワード・動画索引（熊谷さんのやさしい Swift 勉強会）](https://yumemi.notion.site/70fe9df85a7d4e2e81b94fbe1dae8f8e)
