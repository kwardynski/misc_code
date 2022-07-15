import Config

config :todo_list, ToDoList.Repo,
  adapter: Ecto.Adapter.Postgres,
  database: "postgres",
  username: "postgres",
  password: "docker",
  hostname: "localhost",
  log: false

config :todo_list, ecto_repos: [ToDoList.Repo]
