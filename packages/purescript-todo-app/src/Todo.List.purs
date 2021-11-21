module Todo.List (
  mkTodoListComponent
) where

import Prelude

import Data.Array (cons)
import Data.Foldable (length, traverse_)
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Effect (Effect)
import Effect.Console (logShow)
import React.Basic.DOM as R
import React.Basic.DOM.Events as DOM.Events
import React.Basic.Events as Events
import React.Basic.Hooks (Component, component, useState, (/\))
import React.Basic.Hooks as React
import Todo.Task (Task, mkTaskComponent)
import Todo.Utils (classy)

data Action =
    CreateTask String
  | CompleteTask Int
  | UpdateTask Int String
  | DeleteTask Int
  | CompleteAllTasks
  | ClearCompleted
  | None

derive instance showGenericAction :: Generic Action _
instance showAction :: Show Action where
  show = genericShow

mkTodoListComponent :: Component (Array Task)
mkTodoListComponent = do
  taskComponent <- mkTaskComponent
  component "TodoListComponent" \_ -> React.do
   newTask /\ setNewTask <- useState ""
   tasks /\ setTasks <- useState []
   let
     dispatch :: Action -> Effect Unit
     dispatch action = do
       case action of
         CreateTask task -> setTasks (\_ -> cons { id: (length tasks) + 1, completed: false, description: task } tasks)
         _ -> logShow action

     submit :: String -> Maybe String -> Effect Unit
     submit task (Just "Enter") = do
       dispatch (CreateTask task)
       setNewTask $ const ""
     submit _ _ = dispatch None
   pure $ classy R.section "todoapp" [
        classy R.header "header" [
            R.h1_ [R.text "Todos"]
          , R.input {   type: "text"
                      , autoFocus: true
                      , value: newTask
                      , className: "new-todo"
                      , placeholder: "What needs to be done?"
                      , onKeyDown: Events.handler DOM.Events.key (submit newTask)
                      , onChange: Events.handler DOM.Events.targetValue $ traverse_ (setNewTask <<< const) }
        ]
      , classy R.section "main" [
            R.input { type: "checkbox"
                    , className: "toggle-all"
                    , id: "toggle-all" }
          , R.label { htmlFor: "toggle-all", children: [ R.text "Mark all as completed" ] }
          , R.ul { className: "todo-list", children: map taskComponent tasks}
        ]
      , classy R.footer "footer" [
            R.span { className: "todo-count", children: [
              R.strong { children: [ R.text "0" ] } , R.text " item left" ] }
          , R.ul { className: "filters", children: [
                 R.li_ [ R.a { className: "selected", href: "#/", children: [ R.text "All" ] } ]
              ,  R.li_ [ R.a { href: "#/active", children: [ R.text "Active" ] } ]
              ,  R.li_ [ R.a { href: "#/completed", children: [ R.text "Completed" ] } ]
            ] }
          , R.button { className: "clear-completed", children: [ R.text "Clear completed" ] }
       ]
      ]
