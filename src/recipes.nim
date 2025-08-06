# recipes.nim

import std/asynchttpserver
import std/asyncdispatch
import os
import nimja/parser
# ここで、アクセスしたページで何をさせるのか等の情報を打ち込むページ

# TODO: renderTemplateを考える。Nimjaは、動的な置換えに弱すぎる。
# これなら、自作したほうが速いんじゃないかと思うほど。
# 別のテンプレートエンジンを考えるべきだ。


proc renderIndex(title: string, name: string): string =
  compileTemplateFile("../template/index.nimja", baseDir = getScriptDir())

proc renderAbout(title: string, name: string,age:int): string =
  compileTemplateFile("../template/index.nimja", baseDir = getScriptDir())


proc cb*(req:Request) {.async.} = 
  echo (req.reqMethod, req.url, req.headers)
  let headers = {"Content-type":"text/plain; charset = utf-8"}
  await req.respond(Http200,"Hello World",headers.newHttpHeaders())

proc indexHandler*(req:Request){.async.}=
  await req.respond(Http200,renderIndex("CoffeeCat", "piyopiyo"))
  
proc aboutHandler*(req:Request){.async.}=
  await req.respond(Http200,renderAbout("CoffeeCat", "piyopiyo", 20))

proc userHandler*(req:Request,userId:string){.async.}=
  let body = "<h1>User ID: " & userId & "</h1>"
  await req.respond(Http200,body)
