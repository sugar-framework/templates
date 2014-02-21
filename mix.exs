defmodule Templates.Mixfile do
  use Mix.Project

  def project do
    [ app: :templates,
      version: "0.0.1",
      elixir: "~> 0.12.3",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Templates, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps(:prod) do
    [
      { :erlydtl, github: "erlydtl/erlydtl" },
      { :calliope, github: "nurugger07/calliope" }
    ]
  end

  defp deps(:docs) do
    deps(:prod) ++
      [ 
        { :ex_doc, github: "elixir-lang/ex_doc" } 
      ]
  end

  defp deps(_) do
    deps(:prod)
  end
end
