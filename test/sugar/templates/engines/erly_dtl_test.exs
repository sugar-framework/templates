defmodule Sugar.Templates.Engines.ErlyDTLTest do
  use ExUnit.Case

  test "compile/1" do
    template = %Sugar.Templates.Template{
      key: "index.html.dtl",
      source: "<html><head><title>{{ name }}</title></head></html>",
      engine: Sugar.Templates.Engines.ErlyDTL
    }
    {status, t} = template.engine.compile(template)

    assert status === :ok
    assert t.source === nil
  end

  test "render/2" do
    template = %Sugar.Templates.Template{
      key: "index.html.dtl",
      source: "<html><head><title>{{ name }}</title></head></html>",
      engine: Sugar.Templates.Engines.ErlyDTL
    }
    assigns = [name: "Bob"]

    template.engine.compile(template)
    {status, html} = template.engine.render(template, assigns)

    assert status === :ok
    assert html === "<html><head><title>Bob</title></head></html>"
  end
end
