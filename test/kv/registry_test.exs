defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = KV.Registry.start_link([])
    %{registry: registry}
  end

  test "start genserver link" do
    {status, _} = KV.Registry.start_link([])
    assert status == :ok
  end

  test "search for an item in bucket", %{ registry: registry } do
    status = KV.Registry.lookup(registry, 'simple bucket')
    assert status == :error
  end
end
