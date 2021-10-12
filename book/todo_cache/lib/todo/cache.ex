defmodule Todo.Cache do
  use GenServer

  @me __MODULE__ 

  # INTERFACE FUNCTION 
  
  def start() do 
    GenServer.start(Todo.Cache, nil, name: @me)
  end

  def server_process(todo_list_name) do 
    GenServer.call(@me, {:server_process, todo_list_name})
  end

  # INTERNAL
  @impl GenServer
  def init(_) do
    Todo.Database.start()
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        {:ok, new_server} = Todo.Server.start(todo_list_name)
        {:reply, new_server, Map.put(todo_servers, todo_list_name, new_server)}
    end
  end
end
