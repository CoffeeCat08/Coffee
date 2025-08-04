# server.nim - デフォルト対応版
import std/[asynchttpserver, asyncdispatch]
import router

proc main() {.async.} =
  var server = newAsyncHttpServer()
  let port = Port(8080)
  
  echo "Server starting on http://localhost:8080"
  echo "Available routes: /, /about"
  
  await server.serve(port, handleRequest)

when isMainModule:
  waitFor main()