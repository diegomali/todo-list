module Todo.List (
  mkTodoListComponent
) where

import Prelude

import React.Basic.DOM as R
import React.Basic.Hooks (Component, component)
import Todo.Utils (classy)


mkTodoListComponent :: Component {}
mkTodoListComponent = do
  component "TodoListComponent" \_ -> React.do
    pure $ classy R.section "todoapp" [ 
        classy R.header "header" [ 
            R.h1_ [R.text "Todos"]
          , R.input { type: "text", autoFocus: true, className: "new-todo", placeholder: "What needs to be done?" }
        ]
      , classy R.section "main" [
          R.input { type: "checkbox", className: "toggle-all", id: "toggle-all"}
        , R.label { htmlFor: "toggle-all", children: [ R.text "Mark all as completed" ] }
      ]
      
    ]