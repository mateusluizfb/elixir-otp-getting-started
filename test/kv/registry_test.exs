defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(KV.RegistryClient) # Impede que os testes interfiram entre si
    %{registry: registry}
  end

  test "start genserver link" do
    {status, _} = KV.RegistryClient.start_link([])
    assert status == :ok
  end

  test "search for a invalid bucket", %{ registry: registry } do
    status = KV.RegistryClient.lookup(registry, "simple bucket")
    assert status == :error
  end

  test "search for a valid bucket", %{ registry: registry } do
    KV.RegistryClient.create(registry, "GenServer bucket")
    assert {:ok, _} = KV.RegistryClient.lookup(registry, "GenServer bucket")
  end
end
