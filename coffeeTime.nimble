#coffeeTime.nimble

# Package
version       = "0.1.0"
author        = "CoffeeCat08"
description   = "A simple HTTP web framework for Nim"
license       = "MIT"

# Dependencies
requires "nim >= 1.6.0"
requires "nimja"
bin = @["coffeeTimeEngine/server"]

task dev, "Run server in development mode with auto-reload":
  exec "nim c -d:debug -r coffeeTimeEngine/server.nim"