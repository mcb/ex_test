defmodule ExTestTest do
  use ExTest

  setup context do
    {:ok, Dict.put( context, :outer, :setup) }
  end

  test "test still works as before", context do
    assert context[:outer] == :setup
  end

  it "'works as before just using 'it'" do
    assert 0 == 0
  end

  it "works as before just using 'it' with context", context do
    assert context[:outer] == :setup
  end

  describe "with surrounding describe" do
    setup context do
      {:ok, Dict.put( context, :inner, :setup) }
    end

    it "still asserts correctly without context" do
      assert 0 == 0
    end

    it "still asserts correctly with context", context do
      assert context[:inner] == :setup
    end
  end
end
