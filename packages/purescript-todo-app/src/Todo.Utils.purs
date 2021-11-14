module Todo.Utils (
  classy
) where 

import React.Basic.Hooks (JSX)

classy
  :: ({ className :: String, children :: Array JSX } -> JSX)
  -> String
  -> (Array JSX -> JSX)
classy element className children = element { className, children }
