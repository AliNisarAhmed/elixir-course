defmodule Todo.Server do
  use GenServer
  alias Todo.List, as: TodoList

  def start(list_name) do
    GenServer.start(Todo.Server, list_name)
  end

  def add_entry(pid, new_entry) do
    GenServer.cast(pid, {:add_entry, new_entry})
  end

  def entries(pid) do
    GenServer.call(pid, :entries)
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  # -------------------------------------------------

  @impl GenServer
  def init(list_name) do
    {:ok, {list_name, Todo.Database.get(list_name) || TodoList.new()}}
  end

  @impl GenServer
  def handle_call(:entries, _, todo_list) do
    {:reply, TodoList.entries(todo_list), todo_list}
  end

  @impl GenServer
  def handle_call({:entries, date}, _, {_name, todo_list}) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, {name, todo_list}) do
    new_state = TodoList.add_entry(todo_list, new_entry)
    Todo.Database.store(name, new_state)
    {:noreply, {name, new_state}}
  end
end
