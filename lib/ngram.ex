defmodule Ngram do
  @moduledoc """
  ngram module provides means to separate a string into n-grams
  and calculate n-gram distance between two lists/strings
  """

  @ngram_size 2
  @token_type :letter
  @doc """
  tokenize a string into n-grams

  ## Examples:
      iex> Ngram.tokenize("abcdef")
      ["ab", "bc", "cd", "de", "ef"]

      iex> Ngram.tokenize("abcdef", 3)
      ["abc", "bcd", "cde", "def"]

      iex> Ngram.tokenize("free world", 2, :word)
      ["free world"]

      iex> Ngram.tokenize("free world", 2)
      ["fr", "re", "ee", "e ", " w", "wo", "or", "rl", "ld"]


  """
  def tokenize(str, n \\ @ngram_size, token_type \\ @token_type)
  def tokenize(str, n, token_type) when is_binary(str) do
    case token_type do
      :letter -> tokenize(String.codepoints(str), n)
      :word   -> Enum.map(Enum.chunk_every( String.split(str, " ") ,n,1, :discard), fn(token) -> Enum.join(token, " ")  end)
    end
  end
  def tokenize(chars, n, _) when n <= 0 or length(chars) <0, do: :nil
  def tokenize(chars, n, _) do
      Enum.chunk_every(chars, n, 1, :discard) |> Enum.map(&(to_string(&1)))
  end

  @doc """
  find duplicate-aware intersection between lists or stings

  ## Examples:
      iex> Ngram.intersect([1,2,3], [2,3,4])
      [2, 3]
      iex> Ngram.intersect([1,2,2,3], [2,3,4])
      [2, 3]
      iex> Ngram.intersect([1,2,2,3], [2,2,3,4])
      [2, 2, 3]
      iex> Ngram.intersect("abcb", "bbcx")
      ["b", "c", "b"]
      iex> Ngram.intersect("abcb", "")
      []
      iex> Ngram.intersect(["free","world"], ["free"])
      ["free"]

  """
  def intersect(a, b) when is_binary(a) and is_binary(b) do
    intersect(String.codepoints(a), String.codepoints(b))
  end
  def intersect(a, b), do: a -- (a -- b)

  def calculate(a, b) do
    calculate(a, b, @ngram_size)
  end

  @doc """
  calculate n-gram distance between two lists or strings

  ## Examples:
      iex> Ngram.calculate([1,2,3], [2,3])
      0.5
      iex> Ngram.calculate("lorem ipsum", "lorem dolor", 1)
      0.5454545454545454
      iex> Ngram.calculate("lorem", "merol")
      0.0
      iex> Ngram.calculate("lorem", "lorem")
      1
      iex> Ngram.calculate("lorem", "merol", 1)
      1.0
      iex> Ngram.calculate("lorem", "xcvbn", 1)
      0.0
  """
  def calculate(a, b, size) when size == 0 or
    byte_size(a) < size or byte_size(b) < size, do: nil
  def calculate(a, b, _) when a == b, do: 1
  def calculate(a, b, size) do
    na = a |> tokenize(size)
    nb = b |> tokenize(size)
    (intersect(na, nb) |> length) / max(length(na), length(nb))
  end
end
