defmodule PtrLab1.Week2 do

  @doc """
  Write a function that determines whether an input integer is prime.

  ## Examples
    iex> PtrLab1.Week2.isPrime(24)
    false
  """
  def isPrime(number) do
    divisors = Enum.filter((2..number), fn x -> rem(number, x) == 0 end)
    cond do
      length(divisors) == 1 ->
        true
      length(divisors) > 1 ->
        false
    end
  end


  @doc """
  Write a function to calculate the area of a cylinder, given it’s height and
  radius.

  ## Examples
    iex> PtrLab1.Week2.cylinderArea(3 , 4)
    175.9292
  """
  def cylinderArea(height, radius) do
    :erlang.float_to_binary(2 * :math.pi * radius * height + 2 * :math.pi * :math.pow(radius, 2), [decimals: 4])
    |> String.to_float()
  end


  @doc """
  Write a function to reverse a list.

  ## Examples
    iex> PtrLab1.Week2.reverse([1 , 2 , 4 , 8 , 4])
    [4, 8, 4, 2, 1]
  """
  def reverse(list) do
    Enum.reverse(list)
  end


  @doc """
  Write a function to calculate the sum of unique elements in a list.

  ## Examples
    iex> PtrLab1.Week2.uniqueSum([1, 2, 4, 8, 4, 2])
    15
  """
  def uniqueSum(list) do
    Enum.frequencies(list) |> Map.keys() |> Enum.sum()
  end


  @doc """
  Write a function that extracts a given number of randomly selected elements
  from a list.
  """
  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end


  @doc """
  Write a function that returns the first n elements of the Fibonacci sequence.

  ## Examples
    iex> PtrLab1.Week2.firstFibonacciElements(7)
    [1, 1, 2, 3, 5, 8, 13]
  """
  def firstFibonacciElements(x) do
    Stream.unfold({1, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(x)
  end


  @doc """
  Write a function that receives as input three digits and arranges them in an
  order that would create the smallest possible number. Numbers cannot start with a 0.

  ## Examples
    iex> PtrLab1.Week2.smallestNumber(0, 3, 4)
    304
  """
  def smallestNumber(a, b, c) do
    sorted_list = Enum.sort([a, b, c])
    list = cond do
      Enum.count([a, b, c], fn x -> x == 0 end) == 0 ->
        sorted_list
      Enum.count([a, b, c], fn x -> x == 0 end) == 1 ->
        [Enum.at((sorted_list), 1), 0, Enum.at((sorted_list), 2)]
      Enum.count([a, b, c], fn x -> x == 0 end) == 2 ->
        [Enum.at((sorted_list), 2), 0, 0]
    end
    Enum.reduce(list, "", fn x, acc ->
      acc <> "#{x}"
    end)
    |> String.to_integer()
  end


  @doc """
  Write a function that would rotate a list n places to the left.

  ## Examples
    iex> PtrLab1.Week2.rotateLeft([1, 2, 4, 8, 4], 3)
    [8, 4, 1, 2, 4]
  """
  def rotateLeft(list, n) do
    left = Enum.split(list, n) |> Tuple.to_list() |> List.first()
    right = Enum.split(list, n) |> Tuple.to_list() |> List.last()
    right ++ left
  end


  @doc """
  Write a function that eliminates consecutive duplicates in a list.

  ## Examples
    iex> PtrLab1.Week2.removeConsecutiveDuplicates([1, 2, 2, 2, 4, 8, 4])
    [1, 2, 4, 8, 4]
  """
  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end


  @doc """
  Write a function that, given an array of strings, will return the words that can
  be typed using only one row of the letters on an English keyboard layout.

  ## Examples
    iex> PtrLab1.Week2.lineWords(["Hello" ,"Alaska" ,"Dad" ,"Peace"])
    ["Alaska", "Dad"]
  """
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


  @doc """
  Write a function that, given a dictionary, would translate a sentence. Words
  not found in the dictionary need not be translated.
  """
  def translator(dictionary, original_string) do
    dict = Enum.map(Map.keys(dictionary), &to_string/1)
    String.split(original_string, " ")
    |> Enum.map(fn x -> if Enum.member?(dict, x), do: Map.get(dictionary, String.to_atom(x)), else: x end)
    |> Enum.join(" ")
  end


  @doc """
  Create a pair of functions to encode and decode strings using the Caesar cipher.

  ## Examples
    iex> PtrLab1.Week2.encode("lorem", 3)
    "oruhp"
  """
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


  @doc """
  Write a function that lists all tuples a, b, c such that a^2 + b^2 = c^2 and a, b ≤ 20.
  """
  def listRightTriangles() do
    a = for a <- 1..20, b <- 1..20 do
      c = a*a + b*b
      if :math.sqrt(c) - trunc(:math.sqrt(c)) == 0 do
        {a, b, trunc(:math.sqrt(c))}
      end
    end
    Enum.reject(a, fn x -> is_nil(x) end)
  end


  @doc """
  White a function that, given a string of digits from 2 to 9, would return all
  possible letter combinations that the number could represent (think phones with buttons).

  ## Examples
    iex> PtrLab1.Week2.lettersCombinations("23")
    ["ad" ,"ae" ,"af" ,"bd" ,"be" ,"bf" ,"cd" ,"ce" ,"cf"]
  """
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


  @doc """
  White a function that, given an array of strings, would group the anagrams
  together.
  """
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


  @doc """
  Write a function to find the longest common prefix string amongst a list of
  strings.

  ## Examples
    iex> PtrLab1.Week2.commonPrefix(["flower" ,"flow" ,"flight"])
    "fl"
  """
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


  @doc """
  Write a function to convert arabic numbers to roman numerals.

  ## Examples
    iex> PtrLab1.Week2.toRoman(13)
    "XIII"
  """
  def toRoman(num) do
    String.duplicate("I", num)
    |> String.replace("IIIII", "V")
    |> String.replace("IIII", "IV")
    |> String.replace("VV", "X")
    |> String.replace("VIV", "IX")
    |> String.replace("XXXXX", "L")
    |> String.replace("XXXX", "XL")
    |> String.replace("LL", "C")
    |> String.replace("LXL", "XC")
    |> String.replace("CCCCC", "D")
    |> String.replace("CCCC", "CD")
    |> String.replace("DD", "M")
    |> String.replace("DCD", "CM")
  end

  def factorize(number) do
    cond do
      isPrime(number) ->
        [number]
      true ->
        Enum.filter((2..number), fn x -> rem(number, x) == 0 end)
        |> Enum.reject(fn x -> !isPrime(x) end)
    end
  end

end
