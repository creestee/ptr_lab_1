defmodule ProcessingLine do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, name: __MODULE__)
  end

  def init(_) do
    children = [
      %{
        id: :splitter,
        start: {Splitter, :start_link, [self()]}
      },
      %{
        id: :nomster,
        start: {Nomster, :start_link, [self()]}
      },
      %{
        id: :joiner,
        start: {Joiner, :start_link, [[]]}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def get_pid(id, pid) do
    {^id, child_pid, _, _} =
      Supervisor.which_children(pid)
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)
    child_pid
  end
end

defmodule Splitter do
  use GenServer

  def start_link(pid) do
    GenServer.start_link(__MODULE__, pid)
  end

  def init(pid) do
    {:ok, pid}
  end

  def handle_cast({:split, input_string}, state) do
    result = input_string |> String.split()
    nomster_pid = ProcessingLine.get_pid(:nomster, state)
    Nomster.nom(nomster_pid, result)
    {:noreply, state}
  end

  def split(pid, input_string) do
    GenServer.cast(pid, {:split, input_string})
  end

end

defmodule Nomster do
  use GenServer

  def start_link(pid) do
    GenServer.start_link(__MODULE__, pid)
  end

  def init(pid) do
    {:ok, pid}
  end

  def handle_cast({:nom, input_list}, state) do
    result = input_list
    |> Enum.map(fn x -> String.downcase(x) end)
    |> Enum.map(fn x -> String.replace(x, ["n", "m"], fn ch -> case ch do
      "n" ->
        "m"
      "m" ->
        "n"
        end
      end)
    end)

    joiner_pid = ProcessingLine.get_pid(:joiner, state)
    Joiner.join(joiner_pid, result)
    {:noreply, state}
  end

  def nom(pid, input_list) do
    GenServer.cast(pid, {:nom, input_list})
  end
end

defmodule Joiner do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:join, input_list}, _state) do
    result = input_list |> Enum.join(" ")
    IO.puts result
    {:noreply, result}
  end

  def join(pid, input_list) do
    GenServer.cast(pid, {:join, input_list})
  end
end
