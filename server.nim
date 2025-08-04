# server.nim - デフォルト対応版
import std/[asynchttpserver, asyncdispatch]
import nimWebRecipes

# 修正1: 間接呼び出しを避けるため、直接分岐する
proc mainHandler(req: Request) {.async.} =
  echo $req.reqMethod & " " & req.url.path
  
  # 修正2: 間接呼び出しではなく、直接的な分岐
  case req.url.path
  of "/":
    await indexHandler(req)
  of "/about":
    await aboutHandler(req)
  else:
    await req.respond(Http404, "<h1>404 Not Found</h1>")

proc main() {.async.} =
  var server = newAsyncHttpServer()
  let port = Port(8080)
  
  echo "Server starting on http://localhost:8080"
  echo "Available routes: /, /about"
  
  # 修正3: serve()を使用してシンプルに
  await server.serve(port, mainHandler)

when isMainModule:
  waitFor main()