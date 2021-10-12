defmodule Todo.Server do
  use GenServer
  alias Todo.List, as: TodoList

  @me __MODULE__

  def start() do
    GenServer.start(Todo.Server, nil, name: @me)
  end

  def add_entry(new_entry) do
    GenServer.cast(@me, {:add_entry, new_entry})
  end

  def entries() do
    GenServer.call(@me, :entries)
  end

  def entries(date) do
    GenServer.call(@me, {:entries, date})
  end

  # -------------------------------------------------

  @impl GenServer
  def init(_) do
    {:ok, TodoList.new()}
  end

  @impl GenServer
  def handle_call(:entries, _, todo_list) do
    {:reply, TodoList.entries(todo_list), todo_list}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    new_state = TodoList.add_entry(todo_list, new_entry)
    {:noreply, new_state}
  end
end
