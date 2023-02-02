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
end

# Running code

IO.inspect(Minimal.isPrime(13))

IO.puts(:erlang.float_to_binary(Minimal.cylinderArea(3, 4), [decimals: 4]))
