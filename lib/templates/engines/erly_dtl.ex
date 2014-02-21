defmodule Templates.Engines.ErlyDTL do
  @behaviour Templates.Engine
  @moduledoc """
  ErlyDTL template engine
  """

  @extensions ["dtl"]

  ## Callbacks

  def compile(templates) when is_list(templates) do
    Enum.map templates, &compile(&1)
  end
  def compile(template) do
    :erlydtl.compile(template.source, binary_to_atom("Templates.CompiledTemplates.ErlyDTL." <> template.key), [out_dir: "./ebin"])
  end

  def render(template, vars) do
    case apply(binary_to_atom("Templates.CompiledTemplates.ErlyDTL." <> template.key), :render, [vars]) do
      {:ok, tpl} -> 
        {:ok, String.from_char_list!(tpl)}
      {:error, reason} -> 
        {:error, reason}
    end
  end
end