defmodule Week4.GoodSupervisor do
  use Supervisor

  def start_link(workers_count) do
    Supervisor.start_link(__MODULE__, workers_count, name: __MODULE__)
  end

  def init(num_workers) do

    children = Enum.map(1..num_workers, fn x -> %{id: x, name: "Worker_#{x}", start: {Week4.Worker, :start_link, [[]] } } end)

    Supervisor.init(children, strategy: :one_for_one)
  end
end

defmodule Week4.Worker do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:echo, msg}, _from, _state) do
    IO.puts msg
    {:noreply, nil}
  end

  def handle_cast(:kill, _state) do
    Process.exit(self(), :kill)
    {:noreply, nil}
  end

  def echo(pid, msg) do
    GenServer.call(pid, {:echo, msg})
  end

  def kill(pid) do
    GenServer.cast(pid, :kill)
  end
end
