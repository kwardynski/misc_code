defmodule ToDoList.LoggerSupervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    children = [
      {ToDoList.Logger, []}
    ]

    opts = [
      strategy: :one_for_one
    ]

    Supervisor.init(children, opts)
  end
end
