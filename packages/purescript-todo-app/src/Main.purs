module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Todo.List (mkTodoListComponent)
import Todo.Task (Task)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  container <- getElementById "app" =<< (map toNonElementParentNode $ document =<< window)
  case container of
    Just c -> do
      todoList <- mkTodoListComponent
      let app = todoList getTasks
      render app c
    Nothing -> throw "Container not found"
  where
    getTasks :: Array Task
    getTasks =
      []
