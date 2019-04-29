defmodule KV.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      { KV.RegistryClient, name: KV.RegistryClient } # Supervisor vai botar um nome no registry
    ]

    Supervisor.init(children, strategy: :one_for_one) # Apenas reinicia o que quebrou
  end
end
