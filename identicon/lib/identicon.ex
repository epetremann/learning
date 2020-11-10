defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  main
  """
  def main(input) do
    %Identicon.Image{ name: input}
    |> hash
    |> get_color
    |> get_grid
    |> filter_odd_squares
    |> generate_icon
  end

  def generate_icon(%Identicon.Image{} = image) do
    rect_size = 50
    color = :egd.color(image.color)
    icon = :egd.create(rect_size*5,rect_size*5)
    for {_value, index} <- image.grid do
      {x,y} = {rem(index,5)*rect_size, div(index,5)*rect_size} 
      IO.inspect {x,y}
      :egd.filledRectangle(icon, {x,y},{x+rect_size,y+rect_size}, color)
    end
    :egd.render(icon) 
    |> IO.inspect
    |> :egd.save(image.name <> ".png")

  end #generate_icon
  @doc """
  generate hash of a string

  ## Examples

      iex> Identicon.hash("elixir")
      [116, 181, 101, 134, 90, 25, 44, 200, 105, 60, 83, 13, 72, 235, 56, 58]

  """
  def hash(%Identicon.Image{name: name } = image) do
    hex = ( for << x <- :crypto.hash(:md5, name)>>, do: x )
    %Identicon.Image{ image | hex: hex}
  end

  def get_color(%Identicon.Image{hex: [r, g, b | _ ]} = image) do
    %Identicon.Image{ image | color: {r, g, b} }
  end

  def get_grid( %Identicon.Image{hex: hex_list} = image) do
    grid = 
      hex_list
      |> Enum.map(fn x -> rem(x+1,2) end)
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(fn x -> x ++ ( x |> Enum.slice(0,2) |> Enum.reverse) end)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end #get_pattern

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = 
      grid
      |> Enum.filter(fn {value, _index} -> value != 0 end)
    %Identicon.Image{image | grid: grid}
  end #filter_odd_squares
end
