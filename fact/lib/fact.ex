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

  def main(n1,n2) do
    for i <- n1..n2 do 
      f = fact(i)
      l = f |> to_charlist |> length
      IO.puts" length of factorial(#{i})=  #{l}"
    end |> Enum.uniq
  end
  :ok
end
