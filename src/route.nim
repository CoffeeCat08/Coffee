# src/route.nim  
import std/[asynchttpserver, asyncdispatch, strutils]
import recipes

# 使用するurlの取り決めを行うところ
# TODO: ゴリ押しのパスパラメータ。これを動的に対応できるように変更する。

proc myRoutes*(req: Request) {.async.} =

  let pathParts = req.url.path.strip(chars = {'/'}).split('/')

  case pathParts.len
  of 1:
    case pathParts[0]
    of "":
      await indexHandler(req)
    of "about": 
      await aboutHandler(req)
    of "hello":
      await cb(req)
    else:
      await req.respond(Http404, "<h1>404 Not Found</h1>")

  of 2:
    if pathParts[0] == "user":
      let userId = pathParts[1]
      await userHandler(req, userId)
    else:
      await req.respond(Http404, "<h1>404 Not Found</h1>")
  
  else:
    await req.respond(Http404, "<h1>404 Not Found</h1>")