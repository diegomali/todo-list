module Todo.TodoList where (
  mkTodoListComponent
)

import Prelude
import React.Basic.DOM as R
import React.Basic.Hooks (Component)
import Todo.Utils (classy)

mkTodoListComponent :: Component {}
mkTodoListComponent = do
  component "TodoListComponent" \_ -> React.do
    pure $ classy R.section "todoapp" [ 
        classy R.header "header" [ R.h1_ [R.text "Todos"] ]
      , R.text "Hello todo list" ]