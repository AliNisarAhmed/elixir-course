defmodule Todo.Entry do 
  defstruct [
    :id,
    :title, 
    date: Date.utc_today()
  ]
end
