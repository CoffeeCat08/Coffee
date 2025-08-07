# coffeeTimeEngine/router.nim - デフォルト対応版
import std/[strutils,tables,asynchttpserver, asyncdispatch]

type 
  RouteHandler = proc(req: Request, params: Table[string, string]): Future[void] {.gcsafe.}
  RouteEntry = object
    pattern: string
    segments: seq[string]
    handler: RouteHandler
  Router* = ref object
    routes: seq[RouteEntry]

proc newRouter*(): Router =
  Router(routes: @[])

proc addRoute*(router: Router, pattern: string, handler: RouteHandler) =
  let segments = pattern.strip(chars = {'/'}).split('/')
  router.routes.add(RouteEntry(pattern: pattern, segments: segments, handler: handler))

proc dispatch(req: Request, routes: seq[RouteEntry]): Future[void] {.async.} =
  let pathSegs = req.url.path.strip(chars = {'/'}).split('/')

  for route in routes:
    if route.segments.len != pathSegs.len:
      continue
  
    var params = initTable[string, string]()
    var match = true

    for i in 0 ..< route.segments.len:
      let patternSeg = route.segments[i]
      let requestSeg = pathSegs[i]

      if patternSeg.startsWith("{") and patternSeg.endsWith("}"):
        let key = patternSeg[1 ..< patternSeg.len-1]
        params[key] = requestSeg
      elif patternSeg != requestSeg:
        match = false
        break
    
    if match:
      await route.handler(req, params)
      return
  
  # ルートが見つからなかった場合は404を返す
  await req.respond(Http404, "<h1>404 Not Found</h1>")

proc createHandler*(router: Router): proc(req: Request): Future[void] {.async, gcsafe.} =
  result = proc(req: Request): Future[void] {.async, gcsafe.} =
    echo $req.reqMethod & " " & req.url.path
    await dispatch(req, router.routes)