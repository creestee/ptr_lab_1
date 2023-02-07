defmodule Minimal do
  def isPrime(number) do
    divisors = Enum.filter((2..number), fn x -> rem(number, x) == 0 end)
    cond do
      length(divisors) == 1 ->
        true
      length(divisors) > 1 ->
        false
    end
  end

  def cylinderArea(height, radius) do
    2 * :math.pi * radius * height + 2 * :math.pi * :math.pow(radius, 2)
  end

  def reverse(list) do
    Enum.reverse(list)
  end

  def uniqueSum(list) do
    Enum.frequencies(list) |> Map.keys() |> Enum.sum()
  end

  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end

  def firstFibonacciElements(x) do
    Stream.unfold({1, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(x)
  end

  def smallestNumber(a, b, c) do
    sorted_list = Enum.sort([a, b, c])
    cond do
      Enum.count([a, b, c], fn x -> x == 0 end) == 0 ->
        sorted_list
      Enum.count([a, b, c], fn x -> x == 0 end) == 1 ->
        [Enum.at((sorted_list), 1), 0, Enum.at((sorted_list), 2)]
      Enum.count([a, b, c], fn x -> x == 0 end) == 2 ->
        [Enum.at((sorted_list), 2), 0, 0]
    end
  end

  def rotateLeft(list, n) do
    left = Enum.split(list, n) |> Tuple.to_list() |> List.first()
    right = Enum.split(list, n) |> Tuple.to_list() |> List.last()
    right ++ left
  end

  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

  def lineWords(list) do
    final_list = []
    first_line = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
    second_line = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
    third_line = ["z", "x", "c", "v", "b", "n", "m"]

    new_list = for word <- list do
      cond do
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in first_line end) ->
          final_list ++ word
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in second_line end) ->
          final_list ++ word
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in third_line end) ->
          final_list ++ word
        true -> nil
      end
    end
    new_list
    |> Enum.reject(fn x -> is_nil(x) end)
  end

  def translator(dictionary, original_string) do
    dict = Enum.map(Map.keys(dictionary), &to_string/1)
    String.split(original_string, " ")
    |> Enum.map(fn x -> if Enum.member?(dict, x), do: Map.get(dictionary, String.to_atom(x)), else: x end)
    |> Enum.join(" ")
  end

  def encode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> x < 97 or 97 + rem(x - 97 + shift, 26) end)
    |> to_string()
  end

  def decode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> x < 97 or 97 + rem(x - 97 - shift, 26) end)
    |> to_string()
  end

  def listRightTriangles() do
    a = for a <- 1..20, b <- 1..20 do
      c = a*a + b*b
      if :math.sqrt(c) - trunc(:math.sqrt(c)) == 0 do
        {a, b, trunc(:math.sqrt(c))}
      end
    end
    Enum.reject(a, fn x -> is_nil(x) end)
  end

  def lettersCombinations(digits) do
    letters = [
      {},
      {"a", "b", "c"},
      {"d", "e", "f"},
      {"g", "h", "i"},
      {"j", "k", "l"},
      {"m", "n", "o"},
      {"p", "q", "r", "s"},
      {"t", "u", "v"},
      {"w", "x", "y", "z"}
    ]

    digits
    |> String.graphemes()
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> Enum.at(letters, x-1) end)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
    |> Enum.reduce(fn x, acc ->
      for a <- acc, b <- x do
        [b | List.wrap(a)]
      end
    end)
    |> Enum.map(fn x -> Enum.reverse(x) end)
    |> Enum.map(fn x -> List.to_string(x) end)
  end

  def groupAnagrams(list) do
    anagrams_maps = Enum.reduce(list, %{}, fn x, acc ->
      Map.put(acc, groupAnagramsUtil(x), []) end)

    Enum.reduce(list, anagrams_maps, fn x, acc ->
      Map.update!(acc, groupAnagramsUtil(x), fn old_value -> old_value ++ [x] end)
    end)

  end

  defp groupAnagramsUtil(word) do
    word
    |> String.to_charlist()
    |> Enum.sort()
    |> List.to_string()
  end

  def commonPrefix(list) do
    min = Enum.min(list)
    max = Enum.max(list)
    index = Enum.find_index(0..String.length(min), fn x -> String.at(min, x) != String.at(max, x) end)
    if index do
      String.slice(min, 0, index)
    else
      min
    end
  end

  def toRoman() do

  end

  def factorize() do

  end

end
