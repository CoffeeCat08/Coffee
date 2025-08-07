# src/urls.nim  

import views
import ../coffeeTimeEngine/router 

# 使用するurlの取り決めを行うところ
# TODO: ゴリ押しのパスパラメータ。これを動的に対応できるように変更する。

proc setUpRoutes*(router: Router) =
  # ルートの設定
  router.addRoute("/", indexHandler)
  router.addRoute("/about", aboutHandler)
  # router.addRoute("/hello", cb)
  router.addRoute("/user/{userId}", userHandler)
  router.addRoute("/blog/{year}/{slug}", blogHandler)