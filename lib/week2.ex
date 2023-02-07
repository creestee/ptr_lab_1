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
