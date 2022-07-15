defmodule ToDoList.Server do
  use GenServer


  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: ToDoListServer)
  end


  def init(:ok) do
    {:ok, %{}}
  end


  def handle_cast({:add_task, name, date, task}, user_list) do

    # Check whether the user has previously logged tasks. If not, add to the User
    # table and GenServer user_list
    user_list = case check_user(user_list, name) do
      :user_present -> user_list
      {:ok, struct} ->
        IO.puts("New user #{name} successfully added!")
        Map.put(user_list, name, struct.id)
      {:error, _} ->
        IO.puts("!! Unable to add new user #{name} !!")
        user_list
    end

    # Attempt to log the new task
    user_id = Map.get(user_list, name)
    with {:error, changeset} <- GenServer.call(ToDoListLogger, {:log_task, user_id, date, task}) do
      IO.puts("!! Unable to log task #{task} for #{name} !!\n#{inspect changeset}")
    end

    {:noreply, user_list}
  end


  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end


  def add_task(name, date, task) do
    GenServer.cast(ToDoListServer, {:add_task, name, date, task})
  end


  def check_user(user_list, name) do
    case Map.has_key?(user_list, name) do
      true  -> :user_present
      false -> GenServer.call(ToDoListLogger, {:add_user, name})
    end
  end



end
