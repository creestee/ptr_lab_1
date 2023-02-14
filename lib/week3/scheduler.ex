defmodule Scheduler do
  def run do

    receive do
      {:DOWN, _ref, :process, _pid, :crash} ->
        start()

      {:DOWN, _ref, :process, _pid, :normal} ->
        :ok

      _ ->
        start()
    end

    run()
  end

  def start do
    worker = spawn(fn -> Worker.worker() end)
    send(worker, :work)
    worker |> Process.monitor
  end

end

defmodule Worker do
  def worker do
    random_number = :rand.uniform(2)
    :timer.sleep(1_000)
    receive do
      _ ->
        cond do
          random_number == 1 ->
            IO.puts "Task succesful : Miau"
          random_number == 2 ->
            IO.puts "Task failed"
            Process.exit(self(), :crash)
        end
    end
  end
end
