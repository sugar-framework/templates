defmodule Templates.Engines.EEx do
  require EEx
  @behaviour Templates.Engine
  @moduledoc """
  EEx template engine
  """

  @extensions ["eex"]

  ## Callbacks

  # def compile(templates) when is_list(templates) do
  #   Enum.map templates, &compile(&1)
  # end
  def compile(template) do
    # EEx.function_from_string binary_to_atom("Templates.CompiledTemplates.ErlyDTL." <> template.key), template.source, [:assigns]
    :ok
  end

  def render(template, vars) do
    # {:ok, apply(__MODULE__, binary_to_atom("Templates.CompiledTemplates.ErlyDTL." <> template.key), [vars])}
    { :ok, Path.expand(template) |> File.read! |> EEx.eval_string(vars)}
  end
end