# 各 Session における Tasks の洗い出し

「全てにチェックが付いたら Pull Request ができる」という条件を自身に付与する。

## Session 1 : AutoLayout
- [x] UIImageViewの幅はUIViewControllerの幅の半分
  - UIViewController というよりも、View そのものに対する制約になっているが大丈夫か？
- [x] 青字のUILabelと赤字のUILabelの幅はUIImageViewの半分
- [x] UIImageViewの高さと幅は同じ
- [x] UIImageViewとUILabelの隙間はあけない
  - StackView により実装した
- [x] UIImageViewの水平中央はUIViewControllerの中央と同じ
- [x] UIImageViewとUILabelを合わせた矩形の垂直中央はUIViewControllerの中央と同じ
  - StackView により実装した
- [x] UIButtonとUILabelの隙間は80pt
- [x] UIButtonとUILabelの水平中央は同じ

以上、8項目