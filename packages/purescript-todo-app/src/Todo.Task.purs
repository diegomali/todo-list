module Todo.Task (
  mkTaskComponent,
  Task
)
where

import Prelude

import React.Basic.DOM as R
import React.Basic.Hooks (Component, component)

type Task =
  { id          :: Int
  , description :: String
  , completed   :: Boolean
  }

mkTaskComponent :: Component Task
mkTaskComponent = do
  component "TaskComponent" \task -> React.do
    pure $ R.li {
               key: show task.id
             , children: [
                  R.div { className: "view", children: [
                      R.input { type: "checkbox", className: "toggle" }
                    , R.label_ [R.text task.description]
                    , R.button { className: "destroy" }
                   ]
                  }
                , R.input { type: "textbox", value: task.description, className: "edit" }
               ]
          }
