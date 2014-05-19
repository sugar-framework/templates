defmodule Templates.Engines.ErlyDTL do
  @moduledoc """
  ErlyDTL template engine
  """

  @behaviour Templates.Engine

  ## Callbacks

  def compile(template) do
    name = Module.concat([Templates.CompiledTemplates.ErlyDTL, template.key])

    case :erlydtl.compile_template(template.source, name, [out_dir: './_build/dev/lib/templates/ebin']) do
      { :ok, ^name } ->
        template = %{ template | source: nil }
        { :ok, template }
      _ ->
        { :error, "Could not create \"#{name}\"" }
    end
  end

  def render(template, vars) do
    case apply(Module.concat([Templates.CompiledTemplates.ErlyDTL, template.key]), :render, [vars]) do
      { :ok, tpl } ->
        { :ok, String.from_char_data!(tpl) }
      { :error, reason } ->
        { :error, reason }
    end
  end
end
