defmodule TextClient.Summary do 

  alias TextClient.State
  
  def display(game = %State{tally: tally}) do 
    IO.puts [ 
      "\n", 
      "Word so far: #{tally.letters |> Enum.join(" ")}",
      "\n", 
      "Guesses left: #{tally.turns_left}",
      "\n", 
      "Words already used: #{MapSet.to_list(tally.used)}"
    ]
    game
  end

end
