defmodule ExTest do
  @moduledoc """
  ExTest is a simple wrapper around ExUnit to support BDD (rspec) like syntax. It aims to be as lightweight as possible and keep the functionality of ExUnit.
  Any options passed to ExTest will be passed on to `ExUnit.Case` (e.g. `async: true`).

  Using `describe` and `it` might aid your test organization and keep your tests more structured. The `it` macro is a wrapper for `ExUnit.Case.test` and works identically,
  however you may call multiple setups and nest these within `describe`s.

  ### Example
  ```
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
  """


  defmacro __using__(options) do
    quote do
      use ExUnit.Case, unquote(options)
      use ExTest.Attributes
      import ExTest, except: [setup: 1, setup: 2]
    end
  end

  @doc """
  Adds module attributes to the ex_test context. As you cannot access module attributes after compilation, this alternative has been provided.
  Instead setting ```@module_attr "foo"``` you may specify it as ```put_module_attribute :module_attr, "foo"```.
  This is particular helpful when dealing with Phoenix Framework as it requires to set the Endpoint for controller tests.
  """
  def put_module_attribute(key, value) do
    ExTest.Attributes.add_module_attributes(key, value)
  end

  @doc """
  Creates a ExUnit.Case.test using a alternative syntax. This macro wraps the test macro and names the case `it`.

  ## Example

  ```elixir
  it "adds two numbers", do: (assert 1 + 1 = 2)
  ```
  """
  defmacro it(name, options) do
    quote do
      ExTest.Attributes.set_module_attributes(__MODULE__)
      test("it #{unquote name}", unquote(options))
    end
  end

  @doc """
  Creates a ExUnit.Case.test using a alternative syntax but with a context.
  """
  defmacro it(name, context, options) do
    quote do
      ExTest.Attributes.set_module_attributes(__MODULE__)
      test("it #{unquote name}", unquote(context), unquote(options))
    end
  end

  defmacro setup(context_name, [do: block]) do
    quote do
      ExUnit.Callbacks.setup(context) do
        {:ok, unquote(context_name)} = @calling_module.__ex_unit__(:setup, context)
        unquote(block)
      end
    end
  end

  @doc """
  Creates a context for multiple setups and nesting `it`s. Please see the module doc for an example.
  """
  defmacro describe(string, [do: block]) do
   described_module = string
          |> String.split(~r/\W/)
          |> Enum.map(&String.capitalize/1)
          |> Enum.join

    calling_module = __CALLER__.module
    module         = Module.concat(calling_module, described_module)

    quote do
      defmodule unquote(module) do
        use ExUnit.Case
        import ExUnit.Callbacks, except: [setup: 1, setup: 2]
        import ExTest
        @calling_module unquote( calling_module )
        ExTest.Attributes.set_module_attributes(unquote(module))
        unquote(block)
      end
    end
  end
end
