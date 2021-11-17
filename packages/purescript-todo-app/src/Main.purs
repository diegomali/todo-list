module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM as R
import Todo.List (mkTodoListComponent)
import Web.DOM.Element (Element)
import Web.DOM.ParentNode (QuerySelector(..), querySelector)
import Web.HTML (window)
import Web.HTML.HTMLDocument (HTMLDocument, toParentNode)
import Web.HTML.Window (document)

selectFromDocument :: QuerySelector -> HTMLDocument -> Effect (Maybe Element)
selectFromDocument query doc = querySelector query $ toParentNode doc

main :: Effect Unit
main = do
  app <- (selectFromDocument (QuerySelector "#app")) =<< document =<< window
  case app of 
    Nothing -> throw "Element with id app not found"
    Just a -> do
      appComponent <- mkTodoListComponent 
      R.render (appComponent { tasks: [{ description: "Teste listagem", id: 1, completed: false }] }) a
