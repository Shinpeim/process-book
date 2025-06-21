## この文書はなんですか？

この文書は*nix系のシステムにおけるプロセスやシグナルなどについて説明することを目的に書かれました。「プロセスとかよくわかってないからちゃんと知りたいな」みたいなひとたちが想定読者です。

## 簡単に試すには

このリポジトリをクローンすると、Docker環境で簡単に試すことができます：

```bash
git clone https://github.com/Shinpeim/process-book.git
cd process-book
```

また、[Releases](https://github.com/Shinpeim/process-book/releases)にはビルド済みのPDFファイルが公開されているので、手軽に読みたい場合はそちらをご利用ください。

## はじめに：Docker環境の準備

この文書では、実際にコマンドを実行してプロセスの動作を確認することが重要です。統一された環境で学習を進めるため、Dockerコンテナを使用することを推奨します。

### 前提条件
- Docker DesktopまたはDockerがインストールされていること
- docker-composeが使えること

### セットアップ手順

#### Docker イメージをビルド

```bash
docker-compose build
```

#### コンテナを起動してシェルに入る

```bash
# コンテナを起動
docker-compose up -d

# コンテナ内のシェルに入る
docker-compose exec process-book bash
```

### 複数ターミナルでの操作について

この文書では、サーバーとクライアントの通信など、複数のターミナルを使用する例が出てきます。その場合は以下のようにして、同じコンテナに複数のシェルでアクセスしてください：

```bash
# ターミナル1（サーバー側）
docker-compose exec process-book bash

# ターミナル2（クライアント側）
docker-compose exec process-book bash
```

### 終了時の片付け
```bash
# コンテナを停止・削除
docker-compose down
```

**注意**: 本文中で「ターミナルを開いてコンテナにログインして」と記載されている箇所は、上記の `docker-compose exec process-book bash` コマンドを実行することを指しています。

## 目次

[導入](/001.md)

[プロセスの生成](/002.md)

[プロセスとファイル入出力](/003.md)

[ファイルディスクリプタ](/004.md)

[preforkサーバーを作ってみよう](/005.md)

[ゾンビプロセスと孤児プロセス](/006.md)

[シグナルとkill](/007.md)

[プロセスグループとフォアグランドプロセス](/008.md)

## ライセンス
<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.ja"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a>

この 作品 は <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.ja">クリエイティブ・コモンズ 表示 - 継承 3.0 非移植 ライセンスの下に提供されています。</a>
