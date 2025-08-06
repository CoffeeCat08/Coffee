# src/views.nim

import std/asynchttpserver
import std/asyncdispatch
import std/tables
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

proc indexHandler*(req:Request,params:Table[string,string]){.async.}=
  let title = "Coffee Time"
  let name = "CoffeeCat"
  await req.respond(Http200,renderIndex(title, name))
  
proc aboutHandler*(req:Request,params:Table[string,string]){.async.}=
  let title = "Coffee Time - About"
  let name = "CoffeeCat"
  await req.respond(Http200,renderAbout(title, name, 20))

proc userHandler*(req:Request,params:Table[string,string]){.async.}=
  let userId = params["userId"]
  let body = "<h1>User ID: " & userId & "</h1>"
  await req.respond(Http200,body)

proc blogHandler*(req:Request,params:Table[string,string]){.async.}=
  let year = params["year"]
  let slug = params["slug"]

  let body = "<h1>Blog Post</h1><p>Year: " & year & "</p><p>Slug: " & slug & "</p>"
  await req.respond(Http200, body)