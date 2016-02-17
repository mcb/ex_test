defmodule ExTest do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      import ExTest
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
end
