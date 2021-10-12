defmodule KeyValueStore do
  use GenServer

  @me __MODULE__

  # Interface functions

  def start do
    GenServer.start(KeyValueStore, nil, name: @me) 
  end

  def put(key, val) do
    GenServer.cast(@me, {:put, key, val})
  end

  def get(key) do
    GenServer.call(@me, {:get, key})
  end

  ## Functions for GenServer

  def init(_) do
    :timer.send_interval(5000, :cleanup)
    {:ok, %{}}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:put, key, val}, state) do
    {:noreply, Map.put(state, key, val)}
  end

  def handle_info(:cleanup, state) do
    IO.puts("Performing cleanup")
    {:noreply, state}
  end
end


#----------------------

defmodule EchoServer do 
  use GenServer 

  @impl GenServer
  def handle_call(some_request, _, server_state) do 
    {:reply, some_request, server_state}
  end
end
