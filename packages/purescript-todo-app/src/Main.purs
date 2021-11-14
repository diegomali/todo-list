module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM as R
import React.Basic.Hooks (Component, JSX, component)
import Web.DOM.Element (Element, className)
import Web.DOM.ParentNode (QuerySelector(..), children, querySelector)
import Web.HTML (window)
import Web.HTML.HTMLDocument (HTMLDocument, toParentNode)
import Web.HTML.Window (document)

import Todo.TodoList
import Todo.Utils (classy)

selectFromDocument :: HTMLDocument -> Effect (Maybe Element)
selectFromDocument = flip querySelector 

main :: Effect Unit
main = do
  app <- (selectFromDocument (QuerySelector "#app")) =<< toParentNode =<< document =<< window
  case app of 
    Nothing -> throw "Element with id app not found"
    Just a -> do
      appComponent <- mkTodoListComponent
      R.render (appComponent {}) a
