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
