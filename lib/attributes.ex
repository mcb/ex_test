defmodule ExTest.Attributes do
  @doc false
  defmacro __using__(opts \\ []) do
    quote do
      Agent.start_link(fn -> %{} end, name: :ex_test_module_attributes)

      import ExTest.Attributes
    end
  end

  @doc false
  def add_module_attributes(key, value) do
    Agent.update(:ex_test_module_attributes, fn(map) -> Map.put(map, key, value) end)
  end

  @doc false
  def set_module_attributes(module_name) do
    attrs = Agent.get(:ex_test_module_attributes, fn map -> map end)
    Enum.map(attrs, fn {k, v} -> Module.put_attribute module_name, k, v end)
  end
end
