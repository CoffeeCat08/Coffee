#coffeetime.nimble

# Package
version       = "0.1.0"
author        = "CoffeeCat08"
description   = "A simple HTTP web framework for Nim"
license       = "MIT"
srcDir        = "src"

# Dependencies
requires "nim >= 1.6.0"

bin = @["../coffeeTimeEngine/server"]