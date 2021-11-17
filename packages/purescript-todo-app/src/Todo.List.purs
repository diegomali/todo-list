module Todo.List (
  mkTodoListComponent
) where

import Prelude

import Effect.Console (log)
import React.Basic.DOM as R
import React.Basic.Hooks (Component, component)
import Todo.Utils (classy)

type Task =
  { description :: String
  , id          :: Int
  , completed   :: Boolean
  }


mkTodoListComponent :: Component { tasks :: Array Task }
mkTodoListComponent = do
  log "TEste"
  component "TodoListComponent" \{ tasks } -> React.do
    pure $ classy R.section "todoapp" [ 
        classy R.header "header" [ 
            R.h1_ [R.text "Todos"]
          , R.input { type: "text", autoFocus: true, className: "new-todo", placeholder: "What needs to be done?" }
        ]
      , classy R.section "main" [
          R.input { type: "checkbox", className: "toggle-all", id: "toggle-all"}
        , R.label { htmlFor: "toggle-all", children: [ R.text "Mark all as completed" ] }
        , R.ul { className: "todo-list", children: map fromTask tasks } 
      ]
      
    ]
  where
    fromTask { description, id,  completed } =
      R.li { children: [
              R.div { className: "view", children: [
                    R.input { type: "checkbox", className: "toggle" }
                  , R.label_ [R.text description]
                  , R.button { className: "destroy" }
                ]
              }
            , R.input { type: "textbox", value: description, className: "edit" }
        ] 
      }
    getTasks = [
      { description: "Teste listagem", id: 1, completed: false }
    ]