defmodule ExTestTest do
  use ExTest

  setup do
    {:ok, outer: :setup }
  end

  test "test still works as before", context do
    assert context[:outer] == :setup
  end

  it "test works as before just using 'it'" do
    assert 0 == 0
  end

  it "test works as before just using 'it' with context", context do
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
      assert context[:outer] == :setup
    end

    describe "nesting 'describe' inside" do
      it "assterts correctly" do
        assert 0 == 0
      end
    end
  end
end
