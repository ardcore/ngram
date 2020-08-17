defmodule NgramTest do
  use ExUnit.Case, async: true
  doctest Ngram

  describe "tokenize/3" do
    test "tokenize/1 with module defaults" do
      assert ["ab", "bc", "cd", "de", "ef"] == Ngram.tokenize("abcdef")
    end

    test "tokenize/3 ngram 2, token = word" do
      assert ["free world"] == Ngram.tokenize("free world", 2, :word)
    end

    test "tokenize with 2-gram letter tokens" do
      assert ["fr", "re", "ee", "e ", " w", "wo", "or", "rl", "ld"] == Ngram.tokenize("free world", 2)
    end
  end

  describe "calculate/3" do
    test "integer lists" do
      assert 0.5 == Ngram.calculate([1,2,3], [2,3])
    end

    test "character with module defaults" do
      assert 0.0 == Ngram.calculate("lorem", "ipsum")
    end

    test "character with 2-char strings" do
      assert 0.0 == Ngram.calculate("li", "il")
    end
  end
end
