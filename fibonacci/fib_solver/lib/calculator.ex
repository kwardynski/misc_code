defmodule FibSolver.Calculator do

  def solve_fib(n) when n < 0, do: {:error, "Value must be positive"}
  def solve_fib(n) do
    cached_fib = GenServer.call(Cache, {:get_value, n})
    case cached_fib do
      nil ->
        fib = solve_fib(n-1) + solve_fib(n-2)
        GenServer.cast(Cache, {:put_value, n, fib})
        fib
      _ -> cached_fib
    end
  end

end
