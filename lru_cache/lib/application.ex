defmodule LRUCache.Application do
  use Application

  @cache_size 5

  @impl true
  def start(_type, _args) do
    children = [
      {LRUCache.Cache, @cache_size}
    ]
    opts = [
      strategy: :one_for_one,
      name: LRUCache
    ]
    Supervisor.start_link(children, opts)
  end

end
