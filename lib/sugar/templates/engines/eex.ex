defmodule Sugar.Templates.Engines.EEx do
  require EEx
  @moduledoc """
  EEx template engine
  """

  @behaviour Sugar.Templates.Engine

  ## Callbacks

  def compile(template) do
    name = Module.concat([Sugar.Templates.CompiledTemplates.EEx, template.key])
    info = [file: __ENV__.file, line: __ENV__.line, engine: EEx.SmartEngine]
    args = Enum.map [:assigns], fn arg -> { arg, [line: info[:line]], nil } end
    compiled = EEx.compile_string(template.source, info)
    contents = quote do
      def(render(unquote_splicing(args)), do: unquote(compiled))
    end

    case name |> Module.create(contents) do
      { :module, ^name, _, _ } ->
        template = %{ template | source: nil }
        { :ok, template }
      _ ->
        { :error, "Could not create \"#{name}\"" }
    end
  end

  def render(template, vars) do
    name = Module.concat([Sugar.Templates.CompiledTemplates.EEx, template.key])
    { :ok, apply(name, :render, [vars]) }
  end
end
