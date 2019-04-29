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

  def handle_cast({:create, name}, {bkt_names, bkt_monitor_refs}) do
    if Map.has_key?(bkt_names, name) do
      {:noreply, {bkt_names, bkt_monitor_refs}}
    else
      {:ok, bucket} = KV.Bucket.start_link()
      ref = Process.monitor(bucket)
      {
        :noreply,
        {
          Map.put(bkt_names, name, bucket),
          Map.put(bkt_monitor_refs, ref, name)
        }
      }
    end
  end

  def handle_info(:insta_kill, state) do
    {:stop, :normal, state}
  end

  def handle_info({:DOWN, ref, :process, _, :normal}, {bkt_names, bkt_monitor_refs}) do
    { name, remaining_monitor_refs } = Map.pop(bkt_monitor_refs, ref)
    {
      :noreply,
      {
        Map.delete(bkt_names, name),
        remaining_monitor_refs
      }
    }
  end

  # TODO  add um handle info padrão

end
