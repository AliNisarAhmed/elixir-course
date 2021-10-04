defmodule Dictionary.WordList do

  def start_link() do 
    Agent.start_link(&start/0, name: __MODULE__)
  end

  def start() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do
    Agent.get(__MODULE__, &Enum.random/1)
  end
end
