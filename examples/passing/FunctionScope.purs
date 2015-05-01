module Main where

  import Prelude

  mkValue :: Number -> Number
  mkValue id = id

  foreign import error
    """
    function error(msg) {
      throw msg;
    }
    """ :: forall a. String -> a

  main = do
    let value = mkValue 1.0
    if value == 1.0
      then Debug.Trace.trace "Done"
      else error "Not done"
