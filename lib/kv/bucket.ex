defmodule KV.Bucket do
  use Agent

  @doc """
  Starts the bucket
  """
  def start_link do
    Agent.start_link fn -> %{} end
  end

  @doc """
  Gets one value from the bucket given a key
  """
  def get(bucket, key) do
    Agent.get bucket, &Map.get(&1, key)
  end

  @doc """
  Adds or updated one value from the bucket given a key and a value
  """
  def put(bucket, key, value) do
    Agent.update bucket, &Map.put(&1, key, value)
  end

  @doc """
  Removes one key and value pair from the given bucket
  """
  def delete(bucket, key) do
    Agent.get_and_update bucket, &Map.pop(&1, key)
  end
end
