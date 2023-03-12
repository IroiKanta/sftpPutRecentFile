#!/bin/bash

# 設定ファイルからファイル検索場所とsftp接続先の情報を取得する
# bash では source コマンドがないのでこれで実行
. $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/config.cfg
# config.cfgは以下のように書いてください
# DIRECTORY=/path/to/directory
# SEARCH_FILE=target
# PORT=ssh port
# HOST=user@host
# REMOTE_DIR=/remote/directory/
# PRIVATE_KEY=/path/to/private/key

# ディレクトリを移動して最新のzipファイルを探す
cd $DIRECTORY
latest_zip=$(find . -name "$SEARCH_FILE" -type f -printf '%T+ %p\n' | sort | tail -n 1 | awk '{print $2}')
echo $latest_zip を送信します

# sftp経由でzipファイルを送信
sftp -i "$PRIVATE_KEY" -P $PORT $HOST << EOF
put "$latest_zip" "$REMOTE_DIR"
