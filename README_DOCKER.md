# Docker環境の使い方

## 前提条件
- Docker DesktopまたはDockerがインストールされていること
- docker-composeが使えること

## セットアップ

Docker イメージをビルド
```bash
docker-compose build
```

## 使い方

### 基本的な使い方
```bash
# コンテナを起動
docker-compose up -d

# コンテナ内のシェルに入る
docker-compose exec process-book bash
```

### 単発でシェルを起動（コンテナが自動削除される）
```bash
docker-compose run --rm process-book
```

### 複数ターミナルでの使用（preforkサーバーなどの動作確認用）
```bash
# ターミナル1
docker-compose up -d
docker-compose exec process-book bash

# ターミナル2（同じコンテナに別シェルで入る）
docker-compose exec process-book bash
```

### 後片付け
```bash
# コンテナを停止・削除
docker-compose down
```

## ディレクトリ構造
- `/app/examples/` - サンプルコード置き場（ホストの`./examples`をマウント）

## 注意事項
- コンテナ内で作成したファイルは`examples`ディレクトリ内なら永続化されます
- ホスト側でファイルを書き換えれば、コンテナ側でも即座に反映されます
- 複数のターミナルから同じコンテナにアクセスできるため、プロセス間通信の実験が可能です
