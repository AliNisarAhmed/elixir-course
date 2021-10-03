defmodule Procs do 

  def greeter(count) do 
    receive do 
      {:boom, reason} ->
        exit(reason)
      {:add, c} -> 
        greeter(count + c)
      { :reset } -> 
        greeter(0)
      msg -> 
        IO.puts("#{count}: #{inspect msg}")
        greeter(count)
    end
  end 

  def inner_process() do 
    Process.sleep(15_000)
    IO.puts("Slept for 15 seconds")
  end

  def outer_process() do 
    spawn(inner_process)
    exit(:bad)
  end

end
