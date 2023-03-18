# CI

> 継続的インテグレーション (CI) とは、ソフトウェアの開発においてコードを頻繁に共有リポジトリにコミットする手法のことです。 コードをコミットする頻度が高いほどエラーの検出が早くなり、開発者がエラーの原因を見つけるためにデバッグしなければならないコードの量も減ります。

https://docs.github.com/ja/actions/automating-builds-and-tests/about-continuous-integration

CI の導入により、研修中にビルドができなくなったり、テストが失敗するようになったことを自動検知し、自身とレビュワーの負荷を減らすことができます。

GitHub には GitHub Actions という仕組みで CI を導入できるようになっています。

https://docs.github.com/ja/actions/learn-github-actions/understanding-github-actions

さらに CI を自分の PC 環境で動かすことも可能です。これにより、研修の CI 環境を業務の CI 環境と切り離すことができるので安心して試せます。

https://docs.github.com/ja/actions/hosting-your-own-runners/about-self-hosted-runners

# 課題
GitHub Actions のセルフホステッドランナーを利用して PR が更新されたらビルドとテストを実行する CI 環境を構築してみよう

## 参考
- [GitHub Actions でセルフホステッドランナーを使う](https://zenn.dev/yumemi_inc/articles/github-actions-hosted-runner)
- [GitHub Actions で XCTest を実行する](https://zenn.dev/yumemi_inc/articles/xctest-github-actions)
