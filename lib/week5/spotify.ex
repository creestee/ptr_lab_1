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
