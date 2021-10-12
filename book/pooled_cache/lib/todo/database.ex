defmodule Todo.Database do
  use GenServer

  @me __MODULE__
  @db_folder "./persist"

  def start() do
    GenServer.start(@me, nil, name: @me)
  end

  def store(key, data) do
    key
    |> choose_worker()
    |> GenServer.cast({:store, key, data})
  end

  def get(key) do
    worker = choose_worker(key)
    GenServer.call(worker, {:get, key})
  end

  # -----------------------------------------

  def init(_) do
    File.mkdir_p!(@db_folder)

    workers =
      for n <- 0..2, into: %{} do
        {:ok, pid} = Todo.DatabaseWorker.start(@db_folder)
        {n, pid}
      end

    IO.inspect(workers)

    {:ok, workers}
  end

  def choose_worker(key) do
    GenServer.call(@me, {:choose_worker, key})
  end

  def handle_call({:choose_worker, key}, _, workers) do
    hash = :erlang.phash2(key, 3)
    {:reply, workers[hash], workers}
  end
end
