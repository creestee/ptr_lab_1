defmodule Semaphore do

  @doc """
  Create a module that would implement a semaphore.
  """

  def create_semaphore(count) do
    {:ok, pid} = Agent.start_link(fn -> [count, count] end)
    pid
  end

  def acquire(semaphore) do
    cond do
      get_current_value(semaphore) > 0 ->
        Agent.update(semaphore, fn x -> [List.first(x), List.last(x) - 1] end)
      true ->
        raise "Semaphore full"
    end
  end

  def release(semaphore) do
    cond do
      get_current_value(semaphore) < get_semaphore_size(semaphore) ->
        Agent.update(semaphore, fn x -> [List.first(x), List.last(x) + 1] end)
      true ->
        raise "Semaphore already emptied"
    end
  end

  defp get_current_value(semaphore) do
    Agent.get(semaphore, fn x -> List.last(x) end)
  end

  defp get_semaphore_size(semaphore) do
    Agent.get(semaphore, fn x -> List.first(x) end)
  end
end
