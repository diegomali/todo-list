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

selectFromDocument :: HTMLDocument -> Effect (Maybe Element)
selectFromDocument doc = querySelector (QuerySelector "#app") (toParentNode doc)

classy
  :: ({ className :: String, children :: Array JSX } -> JSX)
  -> String
  -> (Array JSX -> JSX)
classy element className children = element { className, children }

main :: Effect Unit
main = do
  app <- selectFromDocument =<< document =<< window
  case app of 
    Nothing -> throw "Not found"
    Just b -> do
      appComponent <- mkTaskListComponent
      R.render (appComponent {}) b



mkTaskListComponent :: Component {}
mkTaskListComponent = do
  component "TaskListComponent" \_ -> React.do
    pure $ classy R.section "todoapp" [ 
        classy R.header "header" [ R.h1_ [R.text "Todos"] ]
      , R.text "Hello todo list" ]