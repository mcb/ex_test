defmodule ExTest.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_test,
      version: "0.0.2",
      elixir: "~> 1.0",
      source_url: "https://github.com/mcb/ex_test",
      description: "Wrapper around ExUnit to support BBD (rspec) like syntax",
      package: package,
      deps: deps,
      docs: [
        main: ExTest,
        readme: "README.md"
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Michael C. Beck"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/mcb/ex_test"}
    ]
  end
end
