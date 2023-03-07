# FAF.PTR16.1 -- Project 0
> **Performed by:** Cristian Ionel, group FAF-202
> **Verified by:** asist. univ. Alexandru Osadcenco

## P0W1

**Task 1** -- Write a script that would print the message “Hello PTR” on the screen. Execute it.

```elixir
defmodule PtrLab1.Week1 do
  def hello do
    "Hello PTR"
  end
end
```

This is a simple Elixir module that contains a function called `hello` which returns a string `"Hello PTR"`.

## P0W2

**Task 1** -- Write a function that determines whether an input integer is prime.

```elixir
  def isPrime(number) do
    divisors = Enum.filter((2..number), fn x -> rem(number, x) == 0 end)
    cond do
      length(divisors) == 1 ->
        true
      length(divisors) > 1 ->
        false
    end
  end
```

The function checks if the input has exactly one divisor (besides 1 and itself) by generating a list of divisors using Enum.filter. If the list of divisors has length 1, the input is prime and the function returns true. If the list of divisors has length greater than 1, the input is not prime and the function returns false.


**Task 2** -- Write a function to calculate the area of a cylinder, given it’s height and radius.

```elixir
  def cylinderArea(height, radius) do
    :erlang.float_to_binary(2 * :math.pi * radius * height + 2 * :math.pi * :math.pow(radius, 2), [decimals: 4])
    |> String.to_float()
  end
```

The function first calculates the surface area using the formula 2 * pi * radius * height + 2 * pi * radius^2 and formats the result as a string with four decimal places using the :erlang.float_to_binary function.

Next, the formatted string is converted to a floating-point number using the String.to_float function and returned as the result of the function.

**Task 3** -- Write a function to reverse a list.

```elixir
  def reverse(list) do
    Enum.reverse(list)
  end
```

Self-explanatory :)

**Task 4** -- Write a function to calculate the sum of unique elements in a list.

```elixir
  def uniqueSum(list) do
    Enum.frequencies(list) |> Map.keys() |> Enum.sum()
  end
```

The function first uses the `Enum.frequencies` function to generate a map of unique integers in the input list and their corresponding frequencies. The frequencies are not needed for the calculation of the sum, so the function uses `Map.keys` to extract only the unique integers from the map.

**Task 5** --   Write a function that extracts a given number of randomly selected elements from a list.

```elixir
  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end
```

Self-explanatory x2 :)

**Task 6** --     Write a function that returns the first n elements of the Fibonacci sequence.

```elixir
  def firstFibonacciElements(x) do
    Stream.unfold({1, 1}, fn {a, b} -> {a, {b, a + b}} end) |> Enum.take(x)
  end
```

The function uses the `Stream.unfold` function to generate an infinite stream of Fibonacci numbers. The initial state of the stream is a tuple containing the first two Fibonacci numbers: {1, 1}.

The function then uses a function with pattern matching `fn {a, b} -> {a, {b, a + b}}` end to produce the next element of the stream, which is the sum of the previous two elements. This function uses destructuring to extract the first and second elements of the tuple, and returns a new tuple where the first element is the current Fibonacci number and the second element is a tuple containing the next two Fibonacci numbers.

Finally, the function uses `Enum.take` to extract the first x elements from the infinite stream of Fibonacci numbers and returns the result as a list.

**Task 7** -- Write a function that receives as input three digits and arranges them in an order that would create the smallest possible number. Numbers cannot start with a 0.

```elixir
  def smallestNumber(a, b, c) do
    sorted_list = Enum.sort([a, b, c])
    list = cond do
      Enum.count([a, b, c], fn x -> x == 0 end) == 0 ->
        sorted_list
      Enum.count([a, b, c], fn x -> x == 0 end) == 1 ->
        [Enum.at((sorted_list), 1), 0, Enum.at((sorted_list), 2)]
      Enum.count([a, b, c], fn x -> x == 0 end) == 2 ->
        [Enum.at((sorted_list), 2), 0, 0]
    end
    Enum.reduce(list, "", fn x, acc ->
      acc <> "#{x}"
    end)
    |> String.to_integer()
  end
```

The function first sorts the input integers in ascending order using `Enum.sort`.

Next, the function uses a cond expression to determine the possible arrangements of the input integers. If none of the input integers are zero, then the smallest integer is simply the concatenation of the sorted input integers. If one of the input integers is zero, then the smallest integer is obtained by placing the non-zero digits in ascending order, with zero in the middle. If two of the input integers are zero, then the smallest integer is simply 0.

The function uses `Enum.reduce` to concatenate the digits of the rearranged integers into a string. Finally, the string is converted to an integer using String.to_integer and returned as the result.

**Task 8** -- Write a function that would rotate a list n places to the left.

```elixir
  def rotateLeft(list, n) do
    left = Enum.split(list, n) |> Tuple.to_list() |> List.first()
    right = Enum.split(list, n) |> Tuple.to_list() |> List.last()
    right ++ left
  end
```

The function first uses the `Enum.split` function to split the input list into two parts: the first n elements and the remaining elements. The `Tuple.to_list()` function is used to convert the resulting tuples to lists, and `List.first()` and List.last() functions are used to extract the left and right parts of the split list, respectively.

Next, the function concatenates the right part of the split list with the left part to produce the rotated list. This is done using the `++` operator, which concatenates two lists.

Finally, the function returns the rotated list as the result.

**Task 9** -- Write a function that eliminates consecutive duplicates in a list.

```elixir
  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end
```

Self-explanatory x3 :)

**Task 10** -- Write a function that, given an array of strings, will return the words that can be typed using only one row of the letters on an English keyboard layout.

```elixir
  def lineWords(list) do
    final_list = []
    first_line = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"]
    second_line = ["a", "s", "d", "f", "g", "h", "j", "k", "l"]
    third_line = ["z", "x", "c", "v", "b", "n", "m"]

    new_list = for word <- list do
      cond do
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in first_line end) ->
          final_list ++ word
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in second_line end) ->
          final_list ++ word
        Enum.all?(String.graphemes(String.downcase(word)), fn x -> x in third_line end) ->
          final_list ++ word
        true -> nil
      end
    end
    new_list
    |> Enum.reject(fn x -> is_nil(x) end)
  end
```

The function uses a for loop to iterate over each word in the input list. For each word, the function checks if all the characters in the word belong to the same row of the keyboard. This is done using the `Enum.all?` function and a predicate function that checks if each character in the word is a member of one of the three keyboard rows.

If the word can be typed using only one row of the keyboard, it is added to the final_list. If not, nil is added to the list.

Finally, the function returns the new_list as the result, but first removes all nil elements using the `Enum.reject` function.

**Task 11** -- Write a function that, given a dictionary, would translate a sentence. Words not found in the dictionary need not be translated.

```elixir
  def translator(dictionary, original_string) do
    dict = Enum.map(Map.keys(dictionary), &to_string/1)
    String.split(original_string, " ")
    |> Enum.map(fn x -> if Enum.member?(dict, x), do: Map.get(dictionary, String.to_atom(x)), else: x end)
    |> Enum.join(" ")
  end
```

The function creates a list of all the keys in the dictionary map, converting them to strings using the `to_string` function. It then splits the original_string into a list of words using the `String.split` function with a space character as the delimiter. It then maps over this list of words, checking if each word is a member of the dict list (which contains all the keys from the dictionary map). 

**Task 12** -- Create a pair of functions to encode and decode strings using the Caesar cipher.

```elixir
  def encode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> x < 97 or 97 + rem(x - 97 + shift, 26) end)
    |> to_string()
  end

  def decode(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(fn x -> x < 97 or 97 + rem(x - 97 - shift, 26) end)
    |> to_string()
  end
```

The function `encode` converts the string to a charlist using `String.to_charlist`. It then maps over the charlist, shifting each character by the specified amount using the modulo operator and wrapping around the alphabet as needed. The resulting charlist is then converted back to a string using `to_string`.


`decode` is basically the opposite.

**Task 13** -- Create a pair of functions to encode and decode strings using the Caesar cipher.

```elixir
  def listRightTriangles() do
    a = for a <- 1..20, b <- 1..20 do
      c = a*a + b*b
      if :math.sqrt(c) - trunc(:math.sqrt(c)) == 0 do
        {a, b, trunc(:math.sqrt(c))}
      end
    end
    Enum.reject(a, fn x -> is_nil(x) end)
  end
```

This function generates all possible right triangles with integer sides where each side is at most 20 units long. It does this by iterating through all pairs of integers between 1 and 20 (inclusive) and checking whether the Pythagorean theorem holds for the two numbers.

**Task 14** -- White a function that, given a string of digits from 2 to 9, would return all possible letter combinations that the number could represent (think phones with buttons).

```elixir
  def lettersCombinations(digits) do
    letters = [
      {},
      {"a", "b", "c"},
      {"d", "e", "f"},
      {"g", "h", "i"},
      {"j", "k", "l"},
      {"m", "n", "o"},
      {"p", "q", "r", "s"},
      {"t", "u", "v"},
      {"w", "x", "y", "z"}
    ]

    digits
    |> String.graphemes()
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> Enum.at(letters, x-1) end)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
    |> Enum.reduce(fn x, acc ->
      for a <- acc, b <- x do
        [b | List.wrap(a)]
      end
    end)
    |> Enum.map(fn x -> Enum.reverse(x) end)
    |> Enum.map(fn x -> List.to_string(x) end)
  end
```

The function defines a list of letters corresponding to each digit, then maps the input string to a list of corresponding letters, and uses `Enum.reduce` to compute all possible combinations of those letters. Finally, it maps over the resulting list to reverse each element and convert it to a string.

**Task 15** -- White a function that, given an array of strings, would group the anagrams.

```elixir
  def groupAnagrams(list) do
    anagrams_maps = Enum.reduce(list, %{}, fn x, acc ->
      Map.put(acc, groupAnagramsUtil(x), []) end)

    Enum.reduce(list, anagrams_maps, fn x, acc ->
      Map.update!(acc, groupAnagramsUtil(x), fn old_value -> old_value ++ [x] end)
    end)

  end

  defp groupAnagramsUtil(word) do
    word
    |> String.to_charlist()
    |> Enum.sort()
    |> List.to_string()
  end
```

The function creates a map of anagram groups, where each key in the map is the sorted letters of a word in the input list, and the value is an empty list. It then loops over the input list again, and updates the map to add each word to the list corresponding to its anagram group.

**Task 16** -- White a function that, given an array of strings, would group the anagrams.

```elixir
  def commonPrefix(list) do
    min = Enum.min(list)
    max = Enum.max(list)
    index = Enum.find_index(0..String.length(min), fn x -> String.at(min, x) != String.at(max, x) end)
    if index do
      String.slice(min, 0, index)
    else
      min
    end
  end
```

The function finds the minimum and maximum strings in the list using the `Enum.min` and `Enum.max` functions, respectively. Then it uses `Enum.find_index` to find the index at which the characters in the minimum and maximum strings differ. If such an index is found, it uses String.slice to extract the common prefix up to that index. If no index is found (i.e., all strings in the list are the same), it returns the minimum string.

**Task 17** -- Write a function to convert arabic numbers to roman numerals.

```elixir
  def toRoman(num) do
    String.duplicate("I", num)
    |> String.replace("IIIII", "V")
    |> String.replace("IIII", "IV")
    |> String.replace("VV", "X")
    |> String.replace("VIV", "IX")
    |> String.replace("XXXXX", "L")
    |> String.replace("XXXX", "XL")
    |> String.replace("LL", "C")
    |> String.replace("LXL", "XC")
    |> String.replace("CCCCC", "D")
    |> String.replace("CCCC", "CD")
    |> String.replace("DD", "M")
    |> String.replace("DCD", "CM")
  end
```

It uses a series of string replace operations to replace combinations of I, V, X, L, C, D, and M with their corresponding Roman numeral counterparts, taking into account special cases like IV, IX, XL, XC, CD, and CM. The resulting string is returned as the function's output.

**Task 18** -- Write a function to calculate the prime factorization of an integer.

```elixir
  def factorize(number) do
    cond do
      isPrime(number) ->
        [number]
      true ->
        Enum.filter((2..number), fn x -> rem(number, x) == 0 end)
        |> Enum.reject(fn x -> !isPrime(x) end)
    end
  end
```

To find the prime factors, the function first checks if the input number is prime by calling the `isPrime` function. If the input number is prime, the function returns a list containing only that number. Otherwise, it filters the integers from 2 to number (inclusive) and selects only those integers that are factors of number using the `rem` function. Then, it rejects all the factors that are not prime using the `isPrime` function and returns the resulting list of prime factors.

## P0W3

**Task 1 and 2** -- Create an actor that prints on the screen any message it receives. Create an actor that returns any message it receives, while modifying it.

```elixir
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
```

The *print* actor receives a message, which is expected to be a tuple, and prints the message to the console.

The *modify* actor receives a message and checks if it is either an integer or a string. If it is an integer, it adds 1 to the value and prints it to the console. If it is a string, it converts the string to lowercase and prints it to the console. If the message does not match either of these patterns, it prints `"I don't know how to HANDLE this!"` to the console.

**Task 3** -- Create a two actors, actor one ”monitoring” the other. If the second actor stops, actor one gets notified via a message.

```elixir
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
```

The `CuteSupervisor` module defines a `run` function that takes in the pid of the child actor to be monitored. The run/1 function starts by monitoring the child process using the `Process.monitor` function. It then enters a loop where it waits for messages from the child process. If the child process exits normally, it receives a `{:DOWN, _ref, :process, _pid, :normal}` message and prints a message indicating that the process exited normally. If the child process crashes, it receives a `{:DOWN, _ref, :process, _pid, _not_normal}` message and prints a message indicating that the process crashed.

**Task 4** -- Create an actor which receives numbers and with each request prints out the current average.

```elixir
defmodule Week3.Task4 do

  @doc """
  Create an actor which receives numbers and with each request prints out the
  current average.

  pid = spawn(fn -> Week3.Task4.averager end)
  """

  def averager(acc \\ 0, increment \\ 0) do
    receive do
      number when is_number(number) ->
        IO.puts (acc + number) / (increment + 1)
        averager(acc + number, increment + 1)
      _ ->
        IO.puts "Enter a valid number"
        averager(acc, increment)
    end
  end
end
```

The `averager` function repeatedly receives messages using the `receive` expression. If the message is a number, it adds it to the `acc` value and increments the `increment` value, then prints out the current average by dividing `acc` by `increment`. If the message is not a number, it prints out a warning message.


**Task 5** -- Create an actor which maintains a simple FIFO queue. You should write helper functions to create an API for the user, which hides how the queue is implemented.

```elixir
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
```

This is an implementation of a simple FIFO queue in Elixir, using the Agent module to create an actor that maintains the state of the queue.

The `new_queue` function creates a new queue with an optional initial value, and returns the process ID of the queue.

The `pop` function takes the process ID of a queue and removes and returns the last element of the queue.

The `push` function takes the process ID of a queue and a value, and adds the value to the front of the queue.

The `all` function takes the process ID of a queue and returns all the elements of the queue in a list.

**Task 6** -- Create a module that would implement a semaphore.

```elixir
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
```

The semaphore is implemented using an agent. The agent state is a two-element list, with the first element being the total size of the semaphore and the second element being the count of available permits. The `get_current_value` and `get_semaphore_size` helper functions are used to retrieve the values of these elements.

**Task 7** -- Create a module that would perform some risky business. Start by creating a scheduler actor. When receiving a task to do, it will create a worker node that will perform the task. Given the nature of the task, the worker node is prone to crashes (task completion rate 50%). If the scheduler detects a crash, it will log it and restart the worker node. If the worker node finishes successfully, it should print the result.


```elixir
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
```

The `Scheduler` module has two functions: run and start. The run function listens for messages and restarts the worker node if it crashes. The start function creates a new worker node and sends it a message to start working on the task. It also monitors the worker node for any crashes.

The `Worker` module has a single function called worker. It generates a random number and sleeps for 1 second. If the random number is 1, the task is considered successful and a message is printed to the console. If the random number is 2, the task is considered failed, and the worker node crashes by calling `Process.exit(self(), :crash)`.

## P0W4

**Task 1** -- Create a supervised pool of identical worker actors. The number of actors is static, given at initialization. Workers should be individually addressable. Worker actors should echo any message they receive. If an actor dies (by receiving a “kill” message), it should be restarted by the supervisor. Logging is welcome.

```elixir
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
```

The `Week4.GoodSupervisor` module starts a supervisor with a `:one_for_one` strategy and initializes a number of child workers specified by the `num_workers` argument. The `Week4.Worker` module uses GenServer to handle messages. It responds to `{:echo, msg}` messages by printing msg to the console, and it responds to `:kill` messages by exiting the process. It also provides two convenience functions, `echo` and `kill`, for sending those messages to a specified process ID.

**Task 2** -- Create a supervised processing line to clean messy strings. The first worker in the line would split the string by any white spaces (similar to Python’s str.split method). The second actor will lowercase all words and swap all m’s and n’s (you nomster!). The third actor will join back the sentence with one space between words (similar to Python’s str.join method). Each worker will receive as input the previous actor’s output, the last actor printing the result on screen. If any of the workers die because it encounters an error, the whole processing line needs to be restarted. Logging is welcome.

```elixir
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
```

Each stage is implemented as a separate GenServer process, and the overall processing line is supervised by a Supervisor process. The `ProcessingLine` module provides a convenience function `get_pid` to look up the process ID of a child process by its ID. All the other modules share a similar structure and all the logic goes like this : Splitter casts to Nomster and Nomster casts to Joiner, where the last one prints the result.

**Task 3** -- Write a supervised application that would simulate a sensor system in a car. There should be sensors for each wheel, the motor, the cabin and the chassis. If any sensor dies because of a random invalid measurement, it should be restarted. If, however, the main sensor supervisor system detects multiple crashes, it should deploy the airbags. A possible supervision tree is attached below.

```elixir
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
```

The sensors are implemented as GenServers. There are four sensor modules, `Cabin.Sensor`, `Motor.Sensor`, `Chassis.Sensor`, and `Wheel.Sensor`, which monitor the cabin, motor, chassis, and individual wheels of the car, respectively. Each sensor is started with a `start_link` function that initializes the GenServer process and links it to the `main_supervisor_pid` supervisor process.
Each sensor has a handle_cast function that receives a tuple `{:measure, value}` and checks if the value is less than 0.7. If it is, the sensor crashes by printing an error message and calling the `crash_sensor` function on the `supervisor_pid`. If there have been fewer than four crashes, the `crash_sensor` function calls the `deploy_airbags` function to simulate airbags being deployed, updates the state, and replies with `{:noreply, @num_of_sensors}`. If there have been four or more crashes, the function updates the state and replies with `{:noreply, state - 1}`. If the value is greater than or equal to 0.7, the function replies with nil.
There is also a `Main.Sensor.Supervisor` module that acts as the main supervisor for all the sensors. It starts up four supervisor processes, one for each type of sensor, and one supervisor process for the individual wheel sensors. The `handle_info` function of this module monitors the exit signals of the sensor processes and restarts them as necessary. 

**Task 4** -- Write an application that, in the context of actor supervision. would mimic the exchange in that scene from the movie Pulp Fiction.

```elixir
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
```
The `Brett` GenServer is responsible for answering questions asked by `Jules`. The answers are stored in a map in the answers parameter of the `init` function. The `handle_call` function handles the `:ask_question` call from Jules and responds with the appropriate answer if it exists in the map. If the answer is "What?", it also sends a `:increase_what` cast message to Jules.

The `Jules` GenServer is responsible for asking questions and receiving answers from Brett. The `init` function initializes the `Brett` GenServer and calls the `ask_question` function to ask the first question. The `handle_info` function receives the `:ask_question` message and asks the question by calling `GenServer.call` to Brett. It also schedules the next question by calling `ask_question` again. The `handle_cast` function handles the `:increase_what` cast message and increases the state parameter. If the state exceeds the `@what_max` value, it sends a `:shoot` cast message to Brett and kills itself.

## P0W5

**Task 1, 2 and 3** -- Write an application that would visit this link. Print out the HTTP response status code, response headers and response body. Extract all quotes from the HTTP response body. Collect the author of the quote, the quote text and tags. Save the data into a list of maps, each map representing a single quote. Persist the list of quotes into a file. Encode the data into JSON format. Name the file quotes.json.

```elixir
defmodule Week5.Minimal do
  HTTPoison.start()

  {:ok, response} = HTTPoison.get('https://quotes.toscrape.com/')
  body = Map.get(response, :body)

  {:ok, html} = Floki.parse_document(body)

  quote_text = Floki.find(html, "span.text")
  |> Floki.text(sep: "+")
  |> String.split("+")
  |> Enum.map(fn x -> String.slice(x, 1..-3) end)

  tags = Floki.find(html, "meta.keywords")
  |> Floki.attribute("content")

  authors = Floki.find(html, "small.author")
  |> Floki.text(sep: "+")
  |> String.split("+")

  map = Enum.zip([quote_text, tags, authors])
  |> Enum.map(fn x -> %{quote: elem(x, 0), tags: String.split(elem(x, 1), ","), author: elem(x, 2)} end)

  File.write("./lib/week5/quotes.json", Poison.encode!(map, [pretty: true]), [:binary])
end
```

The code fetches quotes from the website https://quotes.toscrape.com/ using `HTTPoison`, parses the HTML using `Floki`, extracts the quote text, tags, and author names, combines them into a map, and then encodes the map as a JSON string and writes it to a file named "quotes.json".

**Task 4** -- Write an application that would implement a Star Wars-themed RESTful API.

```elixir
defmodule Main.RestRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_server() do
    :ets.new(:database, [:named_table, :set, :public])
    :ets.insert(:database, [
      {1,
      %{title: "Star Wars : Episode IV - A New Hope",
        release_year: 1977,
        director: "George Lucas"}},
      {2,
      %{title: " Star Wars : Episode V - The Empire Strikes Back",
        release_year: 1980,
        director: "Irvin Kershner"}},
      {3,
      %{title: "Star Wars : Episode VI - Return of the Jedi",
        release_year: 1983,
        director: "Richard Marquand"}},
      {4,
      %{title: "Star Wars : Episode I - The Phantom Menace",
        release_year: 1999,
        director: "George Lucas"}},
      {5,
      %{title: "Star Wars : Episode II - Attack of the Clones ",
        release_year: 2002,
        director: "George Lucas"}},
      {6,
      %{title: "Star Wars : Episode III - Revenge of the Sith",
        release_year: 2005,
        director: "George Lucas"}},
      {7,
      %{title: "Star Wars : The Force Awakens",
        release_year: 2015,
        director: "J.J. Abrams"}},
      {8,
      %{title: "Rogue One : A Star Wars Story",
        release_year: 2016,
        director: "Gareth Edwards"}},
      {9,
      %{title: "Star Wars : The Last Jedi",
        release_year: 2017,
        director: "Rian Johnson"}},
      {10,
      %{title: "Solo : A Star Wars Story",
        release_year: 2018,
        director: "Ron Howard"}},
      {11,
      %{title: "Star Wars : The Rise of Skywalker",
        release_year: 2019,
        director: "J.J. Abrams"}},
    ])

    Plug.Cowboy.http Main.RestRouter, [], port: 8080
  end

  defp send(conn, code, data) when is_integer(code) do
    conn
      |> Plug.Conn.put_resp_content_type("application/json")
      |> send_resp(code, Poison.encode!(data))
  end

  defp last_id() do
    :ets.tab2list(:database)
    |> Enum.max_by(fn x -> elem(x, 0) end)
    |> elem(0)
  end

  get "/movies" do
    movies = :ets.tab2list(:database)
    |> Enum.sort() |> Enum.map(fn {id, data} -> %{"id" => id, "title" => data[:title], "release_year" => data[:release_year], "director" => data[:director]} end)

    send(conn, 200, movies)
  end

  get "/movies/:id" do
    id = String.to_integer id
    movie = :ets.tab2list(:database)
    |> Enum.sort() |> Enum.map(fn {id, data} -> %{"id" => id, "title" => data[:title], "release_year" => data[:release_year], "director" => data[:director]} end)
    |> Enum.filter(fn (m) -> m["id"] == id end)
    |> Enum.at(0)

    send(conn, 200, movie)
  end

  post "/movies" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    {:ok,
    %{
      "title" => title,
      "release_year" => release_year,
      "director" => director
    }} = body |> Poison.decode()

    :ets.insert(:database, {last_id() + 1, %{title: title, release_year: release_year, director: director}})

    send(conn, 200, %{"id" => last_id() + 1, "title" => title, "release_year" => release_year, "director" => director})
  end

  put "/movies/:id" do
    id = String.to_integer id
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    {:ok,
    %{
      "title" => title,
      "release_year" => release_year,
      "director" => director
    }} = body |> Poison.decode()

    :ets.insert(:database, {id, %{title: title, release_year: release_year, director: director}})

    send(conn, 200, %{"id" => id, "title" => title, "release_year" => release_year, "director" => director})
  end

  delete "/movies/:id" do
    id = String.to_integer id

    :ets.delete(:database, id)
    send(conn, 200, "")
  end
end
```

This module uses the Plug package to handle HTTP requests and responses. The module defines a number of endpoints for handling `GET`, `POST`, `PUT`, and `DELETE` requests. The endpoints are defined using the `get`, `post`, `put`, and `delete` macros provided by `Plug.Router`. The database of movies is stored in an ETS (Erlang Term Storage) table, which is created and initialized in the `start_server` function. The `send` function is used to send HTTP responses in JSON format. Each endpoint extracts data from the HTTP request, performs the appropriate operation on the database (e.g., inserting a new record or updating an existing one), and sends an appropriate response back to the client.

**Task 5** - Write an application that would use the Spotify API to manage user playlists. It should be able to create a new playlist, add songs to it and add custom playlist cover images.

```elixir
defmodule Spotify do

  HTTPoison.start()

  @token_url "https://accounts.spotify.com/api/token"

  def client_id, do: Application.get_env(:spotify_config, :client_id)
  def secret_key, do: Application.get_env(:spotify_config, :secret_key)
  def refresh_token, do: Application.get_env(:spotify_config, :refresh_token)

  def encoded_credentials, do: :base64.encode("#{client_id()}:#{secret_key()}")

  def headers do
    [
      {"Authorization", "Bearer #{authorize()}"},
      {"Content-Type", "application/json"},
      {"Accept", "application/json"}
    ]
  end

  def get_refresh_token() do
    headers = [
      {"Authorization", "Basic #{__MODULE__.encoded_credentials()}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
    data = "grant_type=authorization_code&code=<INSERT_CODE_HERE>&redirect_uri=http://localhost:8080/callback/"
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.post(@token_url, data, headers)
    body
  end

  defp get_user_id() do
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("https://api.spotify.com/v1/me", headers())
    %{"id" => id} = body |> Poison.decode!()
    id
  end

  defp authorize() do
    data = "grant_type=refresh_token&refresh_token=#{refresh_token()}&scope=ugc-image-upload playlist-modify-private playlist-modify-public user-read-email user-read-private"
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.post(@token_url, data,
    [
      {"Authorization", "Basic #{__MODULE__.encoded_credentials()}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ])

    map_body = body |> Poison.decode!()
    map_body["access_token"]
  end

  def create_playlist(name, description, public \\ false) do
    data = Poison.encode!(%{"name" => name, "description" => description, "public" => public})
    {:ok, %HTTPoison.Response{body: body}} = HTTPoison.post("https://api.spotify.com/v1/users/#{get_user_id()}/playlists", data, headers())
    %{"id" => id} = body |> Poison.decode!()
    id
  end

  def add_song(playlist_id, song_link) do
    song_id = String.split(song_link, "/") |> List.last() |> String.split("?") |> List.first()
    {:ok, %HTTPoison.Response{status_code: status_code}} = HTTPoison.post("https://api.spotify.com/v1/playlists/#{playlist_id}/tracks?uris=spotify:track:#{song_id}", [], headers())
    status_code
  end

  def add_custom_image(playlist_id, image_path) do
    image = File.read!(image_path) |> :base64.encode()
    {:ok, %HTTPoison.Response{status_code: status_code}} = HTTPoison.put("https://api.spotify.com/v1/playlists/#{playlist_id}/images", image, headers())
    status_code
  end
end
```
+ The `authorize` function sends a POST request to the Spotify API token endpoint with the credentials, refresh_token, and desired scope to receive an access_token.
+ `create_playlist` creates a new playlist (no shit, Sherlock) on the Spotify account linked to the user's API credentials. It takes in the name of the playlist, the description, and whether or not the playlist should be public. It sends a POST request to the Spotify API with the necessary information to create the playlist, along with the user's authorization token in the request headers. The function then decodes the response body and extracts the playlist ID from the returned JSON data. It returns this ID to the caller, which can be used for subsequent operations on the playlist, such as adding songs or setting a custom image.
+ `add_song` adds a song to a Spotify playlist given its ID and a link to the song on Spotify. It extracts the song ID from the link by splitting the link string. It then sends a POST request to the Spotify API with the playlist ID and song ID as parameters in the URL
+ `add_custom_image` reads the image file using `File.read!`, then encodes it using `:base64.encode()`. The resulting base64-encoded image is then used in a PUT request to the Spotify API endpoint to update the playlist's image.

## Conclusion

During these 5 weeks I gained basic knowledge about Elixir and its core concepts, and also I learned about a new concurrency model - Actor Model. So mainly I understood what are the `real` actors and how to work with them. I learned what are Supervisors and how I can supervise some processes (workers). I understood what are GenServers and how useful they might get when you work with states. Finally, in the last week, I learned about 2 new modules - Plug and HTTPoison, which in fact they are also useful when creating a web application.   

## Bibliography

1. https://hexdocs.pm/elixir/1.12/Enumerable.html
2. https://hexdocs.pm/elixir/1.13.4/Process.html
3. https://hexdocs.pm/elixir/1.12/Supervisor.html
4. https://hexdocs.pm/elixir/1.12/GenServer.html
5. https://www.educative.io/answers/what-is-handleinfo-in-elixir
6. https://medium.com/learn-elixir/genserver-explained-in-5-minutes-ae5823af4d44
7. https://developer.spotify.com/documentation/general/guides/authorization/
 