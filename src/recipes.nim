# recipes.nim

import std/asynchttpserver
import std/asyncdispatch

# ここで、アクセスしたページで何をさせるのか等の情報を打ち込むページ

proc cb*(req:Request) {.async.} = 
  echo (req.reqMethod, req.url, req.headers)
  let headers = {"Content-type":"text/plain; charset = utf-8"}
  await req.respond(Http200,"Hello World",headers.newHttpHeaders())

proc indexHandler*(req:Request){.async.}=
  await req.respond(Http200,"<h1>Hello,Nim!</h1>")
  
proc aboutHandler*(req:Request){.async.}=
  await req.respond(Http200,"<h1>This is the about page.</h1>")
