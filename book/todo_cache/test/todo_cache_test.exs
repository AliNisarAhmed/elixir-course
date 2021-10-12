defmodule TodoCacheTest do
  use ExUnit.Case
  doctest TodoCache

  test "server_process" do 
    Todo.Cache.start()
    bob_pid = Todo.Cache.server_process("bob")

    assert bob_pid != Todo.Cache.server_process("alice")
    assert bob_pid == Todo.Cache.server_process("bob")
  end

end
