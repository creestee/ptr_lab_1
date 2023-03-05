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
