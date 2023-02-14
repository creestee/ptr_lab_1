defmodule CuteSupervisor do

  @doc """
  Create a two actors, actor one ”monitoring” the other. If the second actor
  stops, actor one gets notified via a message.

  parent = spawn(fn -> CuteSupervisor.run child end)
  """

  def run(child) do
    Process.monitor(child)
    supervise()
  end

  defp supervise() do
    receive do
      {:DOWN, _ref, :process, _pid, :normal} ->
        IO.puts "-- Exited normally --"
      {:DOWN, _ref, :process, _pid, _not_normal} ->
        IO.puts "-- Crashed --"
    end
    supervise()
  end
end

defmodule Child do

  @doc """
  child = spawn(fn -> Child.run end)
  """

  def run() do
    receive do
      :test ->
        :timer.sleep(2_000)
        IO.puts("Process finished")
    end
  end
end
