defmodule Gatehouse.TargetTest do
  use ExUnit.Case
  doctest Gatehouse.Target
  alias Gatehouse.Target

  test "add access_token parameter" do
    uri = Target.add_access_token_to_uri("http://example.com", "1234")
    assert "http://example.com?access_token=1234" == uri
    uri = Target.add_access_token_to_uri("http://example.com?test=hello", "1234")
    assert "http://example.com?access_token=1234&test=hello" == uri
  end
end
