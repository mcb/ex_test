defmodule ExTest do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      import ExTest, except: [setup: 1, setup: 2]
    end
  end

  defmacro it(name, options) do
    quote do
      test("it #{unquote name}", unquote(options))
    end
  end

  defmacro it(name, context, options) do
    quote do
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

  defmacro setup([do: block]) do
    quote do
      raise "Calling setup without a context is unsupported"
    end
  end

  defmacro describe(string, [do: block]) do
    module = string
          |> String.split(~r/\W/)
          |> Enum.map(&String.capitalize/1)
          |> Enum.join
          |> List.wrap
          |> Module.concat

    calling_module = __CALLER__.module

    quote do
      defmodule unquote(module) do
        use ExUnit.Case
        import ExUnit.Callbacks, except: [setup: 1, setup: 2]
        import ExTest
        @calling_module unquote( calling_module )
        unquote(block)
      end
    end
  end
end
