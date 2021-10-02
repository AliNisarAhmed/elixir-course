defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompt, Move}

  def play(game = %State{tally: %{game_state: :won}}) do
    exit_with_message(game, "You WON!")
  end

  def play(game = %State{tally: %{game_state: :lost}}) do
    exit_with_message(game, "Sorry, you lost")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_message(game, "Good guess!")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_message(game, "Sorry, this is'nt in the word")
  end

  def play(game = %State{tally: %{game_state: :alread_used}}) do
    continue_with_message(game, "You've already used that letter")
  end

  def play(game) do
    continue(game)
  end

  def continue(game = %State{}) do
    game
    |> Summary.display()
    |> Prompt.accept_move()
    |> Move.move()
    |> play
  end

  # ---------- PRIVATE -----------------

  defp continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  defp exit_with_message(game, msg) do
    IO.puts(msg)
    IO.puts("The word was: #{game.tally.full_word}")
    exit(:normal)
  end
end
