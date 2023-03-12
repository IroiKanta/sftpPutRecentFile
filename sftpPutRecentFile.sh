#!/bin/bash

# 設定ファイルからファイル検索場所とsftp接続先の情報を取得する
source $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/config.cfg
# config.cfgは以下のように書いてください
# DIRECTORY=/path/to/directory
# HOST=user@host
# REMOTE_DIR=/remote/directory/
# PRIVATE_KEY=/path/to/private/key

# ディレクトリを移動して最新のzipファイルを探す
cd "$DIRECTORY"
latest_zip=$(find . -name '*.zip' -type f -printf '%T+ %p\n' | sort | tail -n 1 | awk '{print $2}')
echo $latest_zip を送信します

# sftp経由でzipファイルを送信
sftp -i "$PRIVATE_KEY" "$HOST"
put "$latest_zip" "$REMOTE_DIR"