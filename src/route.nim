# src/route.nim  
import std/[asynchttpserver, asyncdispatch]
import recipes

# 使用するurlの取り決めを行うところ

proc myRoutes*(req: Request) {.async.} =
  case req.url.path
  of "/":
    await indexHandler(req)
  of "/about": 
    await aboutHandler(req)
  of "/hello":
    await cb(req)
  else:
    await req.respond(Http404, "<h1>404 Not Found</h1>")