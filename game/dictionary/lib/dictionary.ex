defmodule Dictionary do
  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do 
    Enum.random(word_list())
  end

  def exercise() do 
    str = "had we but world enough, and time"
    str2 = str
    |> String.to_charlist() 

    IO.puts(str2) 

    # str3 = Enum.map_every(str, 1, String.to_integer/1)

    str4 = String.reverse(str) 
    IO.puts(str4)

    String.myers_difference(str, "had we but bacon enough, and treacle")
  end
end
