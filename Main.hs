{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DeriveGeneric #-}

import Web.Scotty
    ( get,
      json,
      jsonData,
      notFound,
      param,
      post,
      scotty,
      status,
      text )
import Network.HTTP.Types.Status
    ( status200, status400, status401 )
import Data.Maybe ( fromMaybe)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Control.Concurrent (newMVar, readMVar, modifyMVar)
import Control.Monad.IO.Class ( MonadIO(liftIO) )
import Data.Time (parseTimeM, Day)
import Data.Time.Format (defaultTimeLocale)
import GHC.Generics
import Data.Aeson ( ToJSON, FromJSON )

type StringDate = String
data Todo = Todo
  { display :: String
  , completed :: Bool }
  deriving (Show, Generic)

instance ToJSON Todo
instance FromJSON Todo

type Task = [Todo]


validateTasks :: Task -> Bool
validateTasks tasks =
  length tasks == 6

validateDay :: String -> Bool
validateDay strDay =
  case x of
    Just  _   -> True
    Nothing  -> False
  where
    x :: Maybe Day = parseTimeM True defaultTimeLocale "%Y-%-m-%-d" strDay

allTasks :: Map StringDate Task
allTasks = Map.fromList
  [ ( "2021-01-02"
    , [ Todo { display = "Create a todo API", completed = True  }
      ]
    )
  , ( "2021-11-03"
    , [ Todo { display = "Add Validations", completed = False  }
      ]
    )
  ]

main :: IO ()
main = do
  tasks' <- newMVar allTasks
  scotty 3000 $ do
    get "/tasks" $ do
      tasks <- liftIO $ readMVar tasks'
      Web.Scotty.json tasks

    get "/tasks/:day" $ do
      tasks <- liftIO $ readMVar tasks'
      day <- param "day"
      Web.Scotty.json $ fromMaybe [] $ Map.lookup day tasks

    post "/tasks/:day" $ do
      day <- param "day"
      newTasks <- jsonData
      if not (validateDay day && validateTasks newTasks)
        then status status400
        else do
          created <- liftIO $ modifyMVar tasks' $ \tasks ->
            if Map.member day tasks
              then return (tasks, False)
              else return (Map.insert day newTasks tasks, True)
          if created
            then status status200
            else status status401
    notFound $ do
      text "NOT FOUND"

