defmodule ToDoList.Schemas.User do
  use ToDoList.Schema
  import Ecto.Changeset

  schema "User" do
    field :name, :string
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

end
