defmodule Cards do
  @moduledoc """
  Methods for crating and handling a deck of cards.
  """

  def create_deck do
    values = ~w(A 1 2 3 4 5 6 7 8 9 10 J Q K)
    suits = ~w(Diamond Heart Spade Club)

    for s <- suits, v <- values, do: {s,v} 
  end #create_deck

  def shuffle(deck) do
    deck |> Enum.shuffle
  end

  def contains?(deck, card) do
    card in deck
  end

  @doc """
  Separates a deck of cards into a hand of size `hand_size` and the
  remainder of the deck.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      [{"Diamond", "A"}]

  """
  def deal(deck, hand_size) do
    deck
    |> Enum.split(hand_size)
  end

  def save(deck, file_name) do
    binary = :erlang.term_to_binary(deck)
    File.write(file_name, binary)
  end

  def restore(file_name) do
    case  File.read(file_name) do
      {:ok, binary} -> binary |> :erlang.binary_to_term
      {:error, _} -> "File #{file_name} does not exist."
    end
  end

  def create_hand(hand_size) do
    create_deck() 
    |> shuffle() 
    |> deal(hand_size)
  end
end #Cards
