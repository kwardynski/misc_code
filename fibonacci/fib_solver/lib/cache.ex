defmodule FibSolver.Cache do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: Cache)
  end

  def init(_) do
    {:ok, %{0 => 1, 1 => 1}}
  end


  # Attempts to retrieve a previously calculated fibonacci value from the cache
  def handle_call({:get_value, n}, _from, cache) do
    {:reply, cache[n], cache}
  end

  # Adds a fibonacci value to the cache
  def handle_cast({:put_value, n, val}, cache) do
    {:noreply, Map.put_new(cache, n, val)}
  end

end
