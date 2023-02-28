defmodule Main.Sensor.Supervisor do
  use GenServer

  @num_of_sensors 7

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: :main_supervisor)
  end

  def init(_) do
    IO.inspect("[INFO] Started Main_Supervisor | #{inspect Process.whereis(:main_supervisor)}")
    Process.flag(:trap_exit, true) # process will convert the received exit signal into an exit message and it will not crash

    [
      Wheels.Sensor.Supervisor.start_link(self()),
      Cabin.Sensor.start_link(self()),
      Motor.Sensor.start_link(self()),
      Chassis.Sensor.start_link(self())
    ]

    {:ok, @num_of_sensors}
  end

  def handle_cast(:crash_sensor, state) do
    if state - 1 <= 4 do
      deploy_airbgs()
      {:noreply, @num_of_sensors}
    else
      {:noreply, state - 1}
    end
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_info({:EXIT, _, :killed}, supervisor_pid) do
    case crashed_sensor() do
      :cabin_sensor ->
        Cabin.Sensor.start_link(self())
      :motor_sensor ->
        Motor.Sensor.start_link(self())
      :chassis_sensor ->
        Chassis.Sensor.start_link(self())
      _ ->
        nil
    end
    {:noreply, supervisor_pid}
  end

  defp crashed_sensor() do
    Enum.find([:cabin_sensor, :motor_sensor, :chassis_sensor], fn x -> !Process.whereis(x) end)
  end

  defp deploy_airbgs() do
    IO.puts("[WARNING] Airbags deployed.")
  end
end

defmodule Wheels.Sensor.Supervisor do
  use GenServer

  def start_link(main_supervisor_pid) do
    GenServer.start_link(__MODULE__, main_supervisor_pid, name: :wheels_supervisor)
  end

  def init(state) do
    IO.inspect("[INFO] Started Wheel_Supervisor | #{inspect Process.whereis(:wheels_supervisor)}")

    Process.flag(:trap_exit, true)

    [
      Wheel.Sensor.start_link(self(), :wheel1),
      Wheel.Sensor.start_link(self(), :wheel2),
      Wheel.Sensor.start_link(self(), :wheel3),
      Wheel.Sensor.start_link(self(), :wheel4)
    ]

    {:ok, state}
  end

  def handle_cast(:stop_sensor, supervisor_pid) do
    GenServer.cast(supervisor_pid, :crash_sensor)
    {:noreply, supervisor_pid}
  end

  def handle_info({:EXIT, _, :killed}, supervisor_pid) do
    Wheel.Sensor.start_link(self(), crashed_sensor())
    {:noreply, supervisor_pid}
  end

  defp crashed_sensor() do
    Enum.find([:wheel1, :wheel2, :wheel3, :wheel4], fn x -> !Process.whereis(x) end)
  end
end
