defmodule Cache do
  def start() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def get(agent, n) do
    Agent.get(agent, &(Map.get(&1, n, -1)))
  end

  def store(agent, k, n) do
    Agent.update(agent, &Map.put(&1, k, n))
  end
end

defmodule Fib do
  alias Cache

  def fib(n) do
    {:ok, cache} = Cache.start()
    fib_with_cache(cache, n)
  end

  defp fib_with_cache(cache, n) do
    case Cache.get(cache, n) do
      -1 ->
        result = fib_with_cache(cache, n - 1) + fib_with_cache(cache, n - 2)
        Cache.store(cache, n, result)
        result

      val ->
        val
    end
  end
end
