defmodule TextClient.Move do 

  alias TextClient.State

  def move(game = %State{}) do  
    {gs, tally} = Hangman.make_move(game.game_service, game.guess)
    %State{game | game_service: gs, tally: tally}
  end

end
