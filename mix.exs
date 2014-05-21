defmodule Templates.Mixfile do
  use Mix.Project

  def project do
    [ app: :templates,
      version: "0.0.2-dev",
      elixir: ">= 0.13.0",
      name: "Sugar",
      deps: deps(Mix.env),
      package: package,
      description: description,
      docs: [readme: true, main: "README"],
      test_coverage: [tool: ExCoveralls] ]
  end

  # Configuration for the OTP application
  def application do
    [ application: [:templates],
      mod: { Templates, [] } ]
  end

  defp deps(:prod) do
    [ { :erlydtl, github: "erlydtl/erlydtl", tag: "0.9.4" },
      { :calliope, github: "nurugger07/calliope" } ]
  end

  defp deps(:docs) do
    deps(:prod) ++
      [ { :ex_doc, github: "elixir-lang/ex_doc" } ]
  end

  defp deps(_) do
    deps(:prod) ++
      [ { :excoveralls, "0.2.0" } ]
  end

  defp description do
    """
    Modular web framework
    """
  end

  defp package do
    %{contributors: ["Shane Logsdon"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sugar-framework/templates",
               "Docs" => "http://sugar-framework.github.io/docs/api/templates/"}}
  end
end
