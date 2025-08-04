# coffeeTimeEngine/router.nim - デフォルト対応版
import std/[asynchttpserver, asyncdispatch]
import ../src/route

# 間接呼び出しを避けて、直接routeTableを呼ぶ
proc handleRequest*(req: Request) {.async.} =
  echo $req.reqMethod & " " & req.url.path
  # 間接呼び出しをやめて、直接importしたrouteを使う
  await myRoutes(req)