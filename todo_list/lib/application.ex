defmodule ToDoList.Application do

  use Application

  @impl true
  def start(_type, _args) do

    # Start the database container
    IO.puts("STARTING DB")
    System.cmd("sh", ["lib/repo/setup_db.sh"])

    children = [
      {ToDoList.Repo, []},
      {ToDoList.ServerSupervisor, []},
      {ToDoList.LoggerSupervisor, []}
    ]

    opts = [strategy: :one_for_one, name: ToDoList.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
