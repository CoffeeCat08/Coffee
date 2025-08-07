# coffeeTimeEngine/server.nim - デフォルト対応版

import std/[asynchttpserver, asyncdispatch]


proc getPort*(): Port =
  # ポート番号を取得する関数
  # デフォルトは8080
  result = Port(8080) 


proc runServer*(port: Port, handler: proc(req: Request): Future[void] {.async, gcsafe.}) {.async.} =

  var server = newAsyncHttpServer()
  await server.serve(port, handler)