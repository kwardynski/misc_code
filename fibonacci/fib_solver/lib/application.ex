defmodule FibSolver.Application do
  use Application

  @impl true
  def start(_type, _args) do

    children = [
      {FibSolver.Cache, []},
      # {FibSolver.Calculator, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: FibSolver
    ]

    Supervisor.start_link(children, opts)

  end
end
