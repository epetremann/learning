defmodule Fact do
  @moduledoc """
  Documentation for `Fact`.
  """

  @doc """

  """
  def fact(n) do
    case n do
      0 -> 1
      _ -> n * fact(n-1)
    end
  end

  def main(n) do
    for i <- 1..n do 
      IO.puts" factorial(#{i})=  #{(fact(i))}"
    end |> Enum.uniq
  end
  :ok
end
