defmodule KV.RegistryServer do
  def init(:ok) do
    bkt_names = %{}
    bkt_monitor_refs = %{}
    {:ok, { bkt_names, bkt_monitor_refs }}
  end

  def handle_call({:lookup, name}, _from, state) do
    { bkt_names, _ } = state
    {:reply, Map.fetch(bkt_names, name), state}
  end

  def handle_cast({:create, name}, {bkt_names, _}) do
    if Map.has_key?(bkt_names, name) do
      {:noreply, {bkt_names, %{}}}
    else
      {:ok, bucket} = KV.Bucket.start_link()
      {:noreply, {Map.put(bkt_names, name, bucket), %{}}}
    end
  end
end
