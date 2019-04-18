defmodule KV.Registry do
  use GenServer

  ### Client

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  # def lookup(server, name) do
  #   Genserver.
  # end

  ### Server

  def init(:ok) do
    {:ok, %{}}
  end
end
