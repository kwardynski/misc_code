defmodule ToDoList.Schemas.Task do
  use ToDoList.Schema
  import Ecto.Changeset

  schema "Task" do
    field :name, :string
    field :date, :date
    field :userid, :binary_id
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> cast(params, [:date])
    |> validate_required([:date])
    |> cast(params, [:userid])
    |> validate_required([:userid])
  end

end
