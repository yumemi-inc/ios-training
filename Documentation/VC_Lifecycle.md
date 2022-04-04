# UIViewControllerのライフサイクル

UIViewControllerのライフサイクルに関するリファレンスをまとめました。よく読んでみてください。  
各コールバック関数に`print`を入れて、動作を確認してみると良いです。

### Viewの生成、表示、非表示
[UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller)  
※`Handling View-Related Notifications`の項  

### レイアウト調整
[viewWillLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews)  
[viewDidLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621398-viewdidlayoutsubviews)

## 課題
- `新しいViewController`を追加する
- アプリケーション起動時に`新しいViewController`に遷移する
- `新しいViewController`が表示されたら、前回まで作ったViewControllerに遷移する
- 前回まで作ったViewControllerのCloseボタンを押下したらViewControllerを閉じるようにする

※イメージ  
![VC_Lifecycle](Images/VC_Lifecycle.gif)
