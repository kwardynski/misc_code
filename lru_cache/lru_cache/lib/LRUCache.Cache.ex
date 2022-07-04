defmodule LRUCache.Cache do
  @moduledoc """
    Genserver handling the cache
  """
  use GenServer

  def start_link(cache_size) do
    GenServer.start_link(__MODULE__, {:ok, cache_size}, name: Cache)
  end

  def init({:ok, cache_size}) do
    {:ok, %{
      cache_size: cache_size,
      cache_list: [],
      cache_map: MapSet.new([])
    }}
  end


  # Main logic driver for updating the cache. Checks whether an item exists in the cache_list.
  # If the item does not exist in the list, it will be appended to the head any any values outside cache_size will be removed
  # If the item does exist in the list, the list will be re-organized
  def handle_item(item) do
    case GenServer.call(Cache, {:in_cache?, item}) do
      true ->
        IO.puts("Item already in the cache")
        GenServer.cast(Cache, {:reorder, item})
      false ->
        IO.puts("Adding new item to cache")
        GenServer.cast(Cache, {:cache_item, item})
    end
    item
  end


  # Cache list retrieval
  def get_cache() do
    GenServer.call(Cache, :get_list)
  end


  # Check whether an item is already cached
  # Use the cache_map for the lookup -> faster than checking the list
  def handle_call({:in_cache?, item}, _, cache) do
    %{cache_map: cache_map} = cache
    {:reply, MapSet.member?(cache_map, item), cache}
  end


  # Re-sort the cache_list if an already cached item is called
  def handle_cast({:reorder, item}, cache) do
    new_list = do_reorder(cache.cache_list, item, [])
    {:noreply, Map.put(cache, :cache_list, new_list)}
  end

  def do_reorder([], item, new_list), do: [item | Enum.reverse(new_list)]
  def do_reorder([head | tail], item, new_list) do
    case head == item do
      true  -> do_reorder(tail, item, new_list)
      false -> do_reorder(tail, item, [head | new_list])
    end
  end


  # Add new item to the cache
  # Drop any values which exceed the cache_size cutoff
  def handle_cast({:cache_item, item}, cache) do
    new_tail = pull_cached(cache.cache_list, [], cache.cache_size, 1) # pull the newest (size-1) items from the cache
    new_cache_list = [item | new_tail]                                # add the new item to the cache

    # Reconstruct the new cache state
    new_cache = cache
    |> Map.put(:cache_list, new_cache_list)                           # re-set the cache list
    |> Map.put(:cache_map, MapSet.new(new_cache_list))                # construct new lookup MapSet from the new cache list

    {:noreply, new_cache}
  end

  def pull_cached(_, new_list, max_size, current_size) when max_size == current_size, do: Enum.reverse(new_list)
  def pull_cached([], new_list, _, _), do: Enum.reverse(new_list)
  def pull_cached([h | t], new_list, max_size, current_size) do
    pull_cached(t, [h | new_list], max_size, current_size+1)
  end


  # Retrieve the cache
  def handle_call(:get_list, _, cache) do
    {:reply, cache.cache_list, cache}
  end

end
