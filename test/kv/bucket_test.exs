defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "returns nil for non matching key" do
    {:ok, bucket} = KV.Bucket.start_link()
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "returns the stored key value" do
    {:ok, bucket} = KV.Bucket.start_link()
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end
