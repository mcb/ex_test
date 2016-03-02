defmodule ExTestTest do
  use ExTest

  put_module_attribute :module_foo, "bar"

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

  it "can access module attributes" do
    assert @module_foo == "bar"
  end

  describe "with surrounding describe" do
    setup context do
      {:ok, Dict.put( context, :inner, :setup) }
    end

    it "accesses module attributes within describe" do
      assert @module_foo == "bar"
    end

    it "still asserts correctly without context" do
      assert 0 == 0
    end

    it "still asserts correctly with context", context do
      assert context[:inner] == :setup
      assert context[:outer] == :setup
    end

    describe "nesting 'describe' inside" do

      it "accesses module attributes" do
        assert @module_foo == "bar"
      end

      it "assterts correctly" do
        assert 0 == 0
      end
    end
  end
end
