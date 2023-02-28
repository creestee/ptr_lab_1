defmodule Cabin.Sensor do
  use GenServer

  def start_link(main_supervisor_pid) do
    GenServer.start_link(__MODULE__, main_supervisor_pid, name: :cabin_sensor)
  end

  def init(main_supervisor_pid) do
    IO.inspect("[INFO] Started Cabin_Sensor")
    {:ok, main_supervisor_pid}
  end

  def handle_cast({:measure, value}, supervisor_pid) when is_float(value) do
    cond do
      value < 0.7 ->
        IO.puts "[CRASH] Cabin_Sensor crashed"
        GenServer.cast(supervisor_pid, :crash_sensor)
        Process.exit(self(), :kill)
      value >= 0.7 ->
        nil
    end
    {:noreply, supervisor_pid}
  end
end

defmodule Motor.Sensor do
  use GenServer

  def start_link(main_supervisor_pid) do
    GenServer.start_link(__MODULE__, main_supervisor_pid, name: :motor_sensor)
  end

  def init(main_supervisor_pid) do
    IO.inspect("[INFO] Started Motor_Sensor")
    {:ok, main_supervisor_pid}
  end

  def handle_cast({:measure, value}, supervisor_pid) when is_float(value) do
    cond do
      value < 0.7 ->
        IO.puts "[CRASH] Motor_Sensor crashed"
        GenServer.cast(supervisor_pid, :crash_sensor)
        Process.exit(self(), :kill)
      value >= 0.7 ->
        nil
    end
    {:noreply, supervisor_pid}
  end
end

defmodule Chassis.Sensor do
  use GenServer

  def start_link(main_supervisor_pid) do
    GenServer.start_link(__MODULE__, main_supervisor_pid, name: :chassis_sensor)
  end

  def init(main_supervisor_pid) do
    IO.inspect("[INFO] Started Chassis_Sensor")
    {:ok, main_supervisor_pid}
  end

  def handle_cast({:measure, value}, supervisor_pid) when is_float(value) do
    cond do
      value < 0.7 ->
        IO.puts "[CRASH] Chassis_Sensor crashed"
        GenServer.cast(supervisor_pid, :crash_sensor)
        Process.exit(self(), :kill)
      value >= 0.7 ->
        nil
    end
    {:noreply, supervisor_pid}
  end
end

defmodule Wheel.Sensor do
  use GenServer

  def start_link(wheels_supervisor_pid, name) do
    GenServer.start_link(__MODULE__, wheels_supervisor_pid, name: name)
  end

  def init(wheels_supervisor_pid) do
    IO.inspect("[INFO] Started Wheel_Sensor")
    {:ok, wheels_supervisor_pid}
  end

  def handle_cast({:measure, value}, supervisor_pid) when is_float(value) do
    cond do
      value < 0.7 ->
        IO.puts "[CRASH] Wheel_Sensor crashed"
        GenServer.cast(supervisor_pid, :stop_sensor)
        Process.exit(self(), :kill)
      value >= 0.7 ->
        nil
    end
    {:noreply, supervisor_pid}
  end
end
