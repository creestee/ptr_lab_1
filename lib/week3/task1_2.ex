defmodule Week3.Task1_2 do
    @doc """
  Create an actor that prints on the screen any message it receives.
  """
  def print do
    receive do
      {msg} ->
        IO.puts(msg)
    end
  end


  @doc """
  Create an actor that returns any message it receives, while modifying it.
  """
  def modify do
    receive do
      {:integer, msg} when is_number(msg) ->
        IO.puts "Received: #{msg + 1}"
      {:string, msg} when is_bitstring(msg) ->
        IO.puts "Received: #{String.downcase(msg)}"
      _ ->
        IO.puts "I don`t know how to HANDLE this!"
    end
  end
end
