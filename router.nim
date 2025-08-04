# router.nim
import std/[tables, asynchttpserver, asyncdispatch]

type
  RequestHandler* = proc(req: Request): Future[void] {.async.}  # 非同期に修正
  Router* = object
    routes*: Table[string, RequestHandler]

proc newRouter*(): Router =
  result.routes = initTable[string, RequestHandler]()

proc addRoute*(router: var Router, path: string, handler: RequestHandler) =
  router.routes[path] = handler