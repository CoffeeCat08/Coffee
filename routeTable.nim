# routeTable.nim  
import std/[asynchttpserver, asyncdispatch]
import nimWebRecipes

proc myRoutes*(req: Request) {.async.} =
  case req.url.path
  of "/":
    await indexHandler(req)
  of "/about": 
    await aboutHandler(req)
  else:
    await req.respond(Http404, "<h1>404 Not Found</h1>")