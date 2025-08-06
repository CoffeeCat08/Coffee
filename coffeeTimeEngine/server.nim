# coffeeTimeEngine/server.nim - デフォルト対応版
import std/[asynchttpserver, asyncdispatch]
import router
import ../src/urls

proc main() {.async.} =
  let router = newRouter()
  setUpRoutes(router)

  let handler = createHandler(router)

  var server = newAsyncHttpServer()
  let port = Port(8080)
  
  echo "Server starting on http://localhost:8080"
  echo "Available routes:"
  echo "/"
  echo "/about"
  echo "/user/{userId}"
  echo "/blog/{year}/{slug}"
  
  await server.serve(port, handler)

when isMainModule:
  waitFor main()