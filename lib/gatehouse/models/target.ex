defmodule Gatehouse.Target do
  def add_access_token_to_uri(url, token) do
    parsed_uri = URI.parse(url)
    access_token = %{access_token: token}
    query_map = case Map.fetch(parsed_uri, :query) do
      {:ok, nil} ->  access_token
      {:ok, query} -> Map.merge(URI.decode_query(query), access_token)
      _ ->  access_token
    end
    parsed_uri
      |> Map.put(:query, URI.encode_query(query_map))
      |> URI.to_string()
  end
end
