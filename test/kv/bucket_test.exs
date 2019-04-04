defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link()
    %{bucket: bucket}
  end

  test "returns nil for non matching key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "returns the stored key value", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "removes returns the deleted key's value", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.delete(bucket, "milk") == 3
  end

  test "removes the stored tuple", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.delete(bucket, "milk")
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
