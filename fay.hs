{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Test_Fay where

import Prelude
import Language.Fay.FFI
  
main :: Fay ()
main = do
  rawTodos <- getTodos
  let todos = fromJSON rawTodos
  let todoCount =  length todos
  let completedTodos = length $ filter isCompleted todos
  let activeTodoCount = todoCount - completedTodos
  let activeTodoWord = if activeTodoCount > 1 then " items " else " item "
   
  footerToggle todoCount
  setFooterHtml $ toHTML (Footer activeTodoCount activeTodoWord completedTodos)
                
  return ()

alert :: String -> Fay ()
alert = ffi "window.alert(%1)"

consoleLog :: String -> Fay ()        
consoleLog = ffi "console.log(%1)"

getTodos :: Fay String
getTodos = ffi "localStorage.getItem('todos-jquery')"

fromJSON :: String -> [a]
fromJSON = ffi "$.parseJSON(%1)"

fromJSON' :: String -> a
fromJSON' = ffi "JSON.parse(%1)"

isCompleted :: a -> Bool
isCompleted = ffi "(%1).completed"

footerToggle :: Int -> Fay ()
footerToggle = ffi "$('#todoapp').find('#footer').toggle(!!(%1))"

setFooterHtml :: String -> Fay()
setFooterHtml = ffi "$('#todoapp').find('#footer').html(%1)"

{-
Failed attempt at using Handlebars templates
                
template :: String -> String                
template = ffi "Handlebars.compile($('#footer-template').html())(%1)"
-}

data Footer = Footer Int String Int

toHTML                     :: Footer -> String
toHTML (Footer activeTodoCount activeTodoWord completedTodos)
       |completedTodos > 0 =     "<span id=\"todo-count\">"
                              ++   "<strong>" ++ show activeTodoCount ++ "</strong>"
                              ++    activeTodoWord ++ "left"
                              ++ "</span>"
                              ++ "<button id=\"clear-completed\">"
                              ++   "Clear completed (" ++ show completedTodos ++ ")"
                              ++ "</button>"
       |otherwise          =     "<span id=\"todo-count\">"
                              ++   "<strong>" ++ show activeTodoCount ++ "</strong>"
                              ++    activeTodoWord ++ "left"
                              ++ "</span>"

  