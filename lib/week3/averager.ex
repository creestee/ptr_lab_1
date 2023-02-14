defmodule Week3.Task4 do

  @doc """
  Create an actor which receives numbers and with each request prints out the
  current average.

  pid = spawn(fn -> Week3.Task4.averager end)
  """

  def averager(acc \\ 0, increment \\ 0) do
    receive do
      number when is_number(number) ->
        IO.puts (acc + number) / (increment + 1)
        averager(acc + number, increment + 1)
      _ ->
        IO.puts "Enter a valid number"
        averager(acc, increment)
    end
  end
end
