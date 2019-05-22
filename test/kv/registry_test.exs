# :debugger.start
# :int.ni(KV.RegistryServer)
# :int.break(KV.RegistryServer, 31)

defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  import Mock

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

  test "removes buckets on exit", %{ registry: registry } do
    KV.RegistryClient.create(registry, "GenServer bucket")
    {:ok, bucket} = KV.RegistryClient.lookup(registry, "GenServer bucket")
    Agent.stop(bucket)
    assert KV.RegistryClient.lookup(registry, "GenServer bucket") == :error
  end

  @tag :skip
  test "Supervisor will revive the dead gensever" do
    {:ok, pid} = KV.Supervisor.start_link([])
    KV.RegistryClient.create KV.RegistryClient, "wallet"
    [h | _] = Supervisor.which_children(pid)
    {KV.RegistryClient, pid_reg, _, _} = h
    send(pid_reg, :insta_kill)

    assert %{active: 1} = Supervisor.count_children(pid)
  end

  test_with_mock "calls the Bucket 'start_link'",  %{ registry: registry }, KV.Bucket, [],
    [
      start_link: fn ->
        Agent.start_link fn -> %{} end
      end
    ] do
      
    KV.RegistryClient.create(registry, "GenServer bucket")
    assert_called KV.Bucket.start_link
  end
end
