defmodule Main.RestRouter do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_server() do
    :ets.new(:database, [:named_table, :set, :public])
    :ets.insert(:database, [
      {1, %{title: "Star Wars : Episode IV - A New Hope"}},
      {2, %{title: "Star Wars : Episode V - The Empire Strikes Back"}},
      {3, %{title: "Star Wars : Episode VI - Return of the Jedi"}},
      {4, %{title: "Star Wars : Episode I - The Phantom Menace"}},
      {5, %{title: "Star Wars : Episode II - Attack of the Clones"}},
      {6, %{title: "Star Wars : Episode III - Revenge of the Sith"}}
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

  get "/" do
    movies = :ets.tab2list(:database)
    |> Enum.sort() |> Enum.map(fn {id, data} -> %{"id" => id, "title" => data[:title]} end)

    send(conn, 200, movies)
  end

  get "/:id" do
    id = String.to_integer id
    movie = :ets.tab2list(:database)
    |> Enum.sort() |> Enum.map(fn {id, data} -> %{"id" => id, "title" => data[:title]} end)
    |> Enum.filter(fn (m) -> m["id"] == id end)
    |> Enum.at(0)

    send(conn, 200, movie)
  end

  post "/" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    {:ok,
    %{
      "title" => title
    }} = body |> Poison.decode()

    :ets.insert(:database, {last_id() + 1, %{title: title}})

    send(conn, 200, %{"id" => last_id() + 1, "title" => title})
  end

  put "/:id" do
    id = String.to_integer id
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    {:ok,
    %{
      "title" => title
    }} = body |> Poison.decode()

    :ets.insert(:database, {id, %{title: title}})

    send(conn, 200, %{"id" => id, "title" => title})
  end

  delete "/:id" do
    id = String.to_integer id

    :ets.delete(:database, id)
    send(conn, 200, "")
  end
end
