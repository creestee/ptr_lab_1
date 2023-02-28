defmodule Brett do
  use GenServer

  def init(answers) do
    {:ok, answers}
  end

  def start_link() do
    answers =
      %{
        "What does Marsellus Wallace look like?" => "What?",
        "What country you from!?" => "What?",
        ~s("What" ain't no country I know! Do they speak English in "What"?) => "What?",
        "English-motherf****r-can-you-speak-it?" => "Yes.",
        "Then you understand what I'm sayin'?" => "Yes.",
        "Now describe what Marsellus Wallace looks like!" => "What?",
        "Now describe to me what Marsellus Wallace looks like!" => "Well he's... he's... black",
        "... go on!" => " ...and he's... he's... bald",
        "does he look like a bitch?!" => "What?"
      }

    GenServer.start_link(__MODULE__, answers, name: :brett)
  end

  def handle_call({:ask_question, q}, _from, answers) do
    :timer.sleep(500)
    if Map.has_key?(answers, q) do
      IO.puts("[BRETT] - #{answers[q]}")
      cond do
        answers[q] == "What?" ->
          GenServer.cast(:jules, :increase_what)
          {:reply, nil, answers}
        true ->
          nil
      end
    end

    {:reply, nil, answers}
  end

  def handle_cast(:shoot, _) do
    IO.puts("-----------------------")
    IO.puts("[JULES] shoots [BRETT]!")
    IO.puts("-----------------------")
    Process.exit(self(), :kill)
    {:noreply, nil}
  end
end

defmodule Jules do
  use GenServer

  @what_max 4

  def init({questions, _}) do
    Brett.start_link()
    ask_question()

    {:ok, {questions, 0}}
  end

  def start_link() do
    questions = [
      "What does Marsellus Wallace look like?",
      "What country you from!?",
      ~s("What" ain't no country I know! Do they speak English in "What"?),
      "English-motherf****r-can-you-speak-it?",
      "Then you understand what I'm sayin'?",
      "Now describe what Marsellus Wallace looks like!",
      ~s(Say "What" again! C'mon, say "What" again!  I dare ya, I double dare ya motherfucker, say "What" one more goddamn time!),
      "Now describe to me what Marsellus Wallace looks like!",
      "... go on!",
      "does he look like a bitch?!"
    ]

    GenServer.start_link(__MODULE__, {questions, 0}, name: :jules)
  end

  def handle_info(:ask_question, {questions, state}) do
    [h | t] = questions
    IO.puts("[JULES] - #{h}")
    GenServer.call(:brett, {:ask_question, h})
    ask_question()
    {:noreply, {t, state}}
  end

  def handle_cast(:increase_what, {questions, state}) do
    state = state + 1
    if state > @what_max, do: GenServer.cast(:brett, :shoot)
    {:noreply, {questions, state}}
  end

  defp ask_question(delay \\ 1000) do
    Process.send_after(self(), :ask_question, delay)
  end

  def start_movie() do
    __MODULE__.start_link()
  end
end
