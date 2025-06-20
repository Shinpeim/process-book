FROM ruby:3.2-slim

# 基本的なツールのインストール
RUN apt-get update && apt-get install -y \
    procps \
    psmisc \
    strace \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# サンプルコード用のディレクトリを作成
RUN mkdir -p /app/examples

# デフォルトコマンド
CMD ["/bin/bash"]