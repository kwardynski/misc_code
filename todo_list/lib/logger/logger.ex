defmodule ToDoList.Logger do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: ToDoListLogger)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({}, state) do
    {:noreply, state}
  end

  def handle_call({:add_user, name}, _from, state) do
    changeset = ToDoList.Schemas.User.changeset(
      %ToDoList.Schemas.User{},
      %{name: name}
    )
    insert_result = ToDoList.Repo.insert(changeset)
    {:reply, insert_result, state}
  end

  def handle_call({:log_task, user_id, date, task}, _from, state) do
    changeset = ToDoList.Schemas.Task.changeset(
      %ToDoList.Schemas.Task{},
      %{
        name: task,
        date: date,
        userid: user_id
      }
    )
    insert_result = ToDoList.Repo.insert(changeset)
    {:reply, insert_result, state}
  end


end
