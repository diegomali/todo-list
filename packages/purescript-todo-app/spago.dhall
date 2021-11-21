{ name = "purescript-todo-app"
, dependencies =
  [ "console"
  , "arrays"
  , "foldable-traversable"
  , "debug"
  , "effect"
  , "exceptions"
  , "foreign"
  , "foreign-generic"
  , "maybe"
  , "prelude"
  , "psci-support"
  , "react-basic"
  , "react-basic-dom"
  , "react-basic-hooks"
  , "simple-json"
  , "strings"
  , "web-dom"
  , "web-html"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
