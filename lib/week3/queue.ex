defmodule Queue do
  use Agent

  @doc """
  Create an actor which maintains a simple FIFO queue. You should write helper
  functions to create an API for the user, which hides how the queue is implemented.
  """

  def new_queue(initial_value \\ []) do
    {:ok, pid} = Agent.start_link(fn -> initial_value end)
    pid
  end

  def pop(pid) do
    Agent.get_and_update(pid, fn x -> List.pop_at(x, -1) end)
  end

  def push(pid, value) do
    Agent.update(pid, fn x -> [value | x] end)
  end

  def all(pid) do
    Agent.get(pid, fn x -> x end)
  end
end
