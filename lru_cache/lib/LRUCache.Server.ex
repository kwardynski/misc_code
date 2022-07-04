defmodule LRUCache.Server do
  @moduledoc """
    Client-facing functions used to update and access the LRU Cache
  """

  # Stash an item in the cache
  def cache(item) when not is_binary(item), do: {:error, "Item must be a string!"}
  def cache(item) do
    LRUCache.Cache.handle_item(item)
  end

  # Retrieve the ordered cache list
  def get_cache() do
    LRUCache.Cache.get_cache()
  end

end
