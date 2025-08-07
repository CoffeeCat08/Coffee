# src/coffeeTime.nim
import std/asyncdispatch

import ../coffeeTimeEngine/server
import ../coffeeTimeEngine/router

import ../src/urls

proc run*() {.async.} =
  echo "Starting Coffee Time Server..."

  # 1. 設定を読み込み、ポート番号を取得する
  echo "1. Importing settings..."
  let port = getPort()

  # 2. ルーターを初期化する
  echo "2. Initializing router..."
  var router = newRouter()

  # 3. ルートを定義する
  echo "3. Setting up routes..."
  setUpRoutes(router)

  # 4. ミドルウェアを適用する
  echo "4. Applying middlewares..."
  # ここでミドルウェアを登録する処理が入る

  # 5. ルーター情報をもとにハンドラを生成する
  echo "5. Creating handler..."
  let handler = createHandler(router)

  # 6. サーバーを起動する
  echo "6. Running the server!"

  echo "Server starting on http://localhost:8080"
  echo "Available routes:"
  echo "/"
  echo "/about"
  echo "/user/{userId}"
  echo "/blog/{year}/{slug}"

  await runServer(port, handler) # `router`は`handler`に組み込まれているので不要




when isMainModule:
  # ここで、`run`関数の完了を待つ必要がある
  waitFor run()