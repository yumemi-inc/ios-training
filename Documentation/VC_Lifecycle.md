# UIViewControllerのライフサイクル

UIViewControllerのライフサイクルに関するリファレンスをまとめました。よく読んでみてください。  
各コールバック関数に`print`を入れて、動作を確認してみると良いです。

### Viewの生成、表示、非表示
[Work with View Controllers](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/WorkWithViewControllers.html#//apple_ref/doc/uid/TP40015214-CH6-SW1)  
※`Understand the View Controller Lifecycle`の項  

### レイアウト調整
[viewWillLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews)  
[viewDidLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621398-viewdidlayoutsubviews)

# 別画面に遷移して、戻ってきたとき天気予報を更新する
## 課題
- `新しいViewController`を追加する
- アプリケーション起動時に`新しいViewController`に遷移する
- `新しいViewController`が表示されたら、前回まで作ったViewControllerに遷移する
- 前回まで作ったViewControllerのCloseボタンを押下したらViewControllerを閉じるようにする

※イメージ  
![VC_Lifecycle](Images/VC_Lifecycle.gif)