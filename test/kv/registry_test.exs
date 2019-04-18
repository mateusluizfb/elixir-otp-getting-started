defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  test "start genserver link" do
    {status, _} = KV.Registry.start_link([])
    assert status == :ok
  end
end
