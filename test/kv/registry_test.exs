defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(KV.Registry) # Impede que os testes interfiram entre si
    %{registry: registry}
  end

  test "start genserver link" do
    {status, _} = KV.Registry.start_link([])
    assert status == :ok
  end

  test "search for a invalid bucket", %{ registry: registry } do
    status = KV.Registry.lookup(registry, "simple bucket")
    assert status == :error
  end

  test "search for a valid bucket", %{ registry: registry } do
    KV.Registry.create(registry, "GenServer bucket")
    assert {:ok, _} = KV.Registry.lookup(registry, "GenServer bucket")
  end
end
