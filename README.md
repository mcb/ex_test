## ExTest

Simple wrapper around ExUnit to support BDD (rspec) like syntax. It aims to be as lightweight as possible and keep the functionality of ExUnit.
Any options passed to ExTest will be passed on to `ExUnit.Case` (e.g. `async: true`).

Using `describe` and `it` might aid your test organization and keep your tests more structured. The `it` macro is a wrapper for `ExUnit.Case.test` and works identically, however you may call multiple setups and nest these within `describes`.

ExTest is right now in an alpha state, however it is improved over time as it is actively used within a bigger project.

### Usage

```elixir
defmodule HelloWorldTest do
  use ExTest #, async: true

  describe "with some assigns" do
    setup context do
      {:ok, hello: :world}
    end

    describe "and some more assigns" do
      setup context do
        {:ok, Dict.put(context, foo: :bar)}
      end

      it "returns things from first context", context do
        assert context[:hello] == :world
      end

      it "returns things from nested context", context do
        assert context[:foo] == :bar
      end
    end
  end
end
```

### Build Status

[![Build Status](https://semaphoreci.com/api/v1/mcb/ex_test/branches/master/badge.svg)](https://semaphoreci.com/mcb/ex_test)

### Installation


Add `ex_test` to your list of dependencies in `mix.exs`:

```elixir
  def deps do
    [{:ex_test, "~> 0.0.1", only: :test}]
  end
```

### Pull requests
Pull requests to improve this software are very welcome. However please note, that this should not be considered as a `rspec` clone, so please keep this in mind when developing features. Thanks!
