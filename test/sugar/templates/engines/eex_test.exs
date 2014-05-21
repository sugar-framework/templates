defmodule Sugar.Templates.Engines.EExTest do
  use ExUnit.Case

  test "compile/1" do
    template = %Sugar.Templates.Template{
      key: "index.html.eex",
      source: "<html><head><title><%= @name %></title></head></html>",
      engine: Sugar.Templates.Engines.EEx
    }
    {status, t} = template.engine.compile(template)

    assert status === :ok
    assert t.source === nil
  end

  test "render/2" do
    template = %Sugar.Templates.Template{
      key: "index.html.eex",
      source: "<html><head><title><%= @name %></title></head></html>",
      engine: Sugar.Templates.Engines.EEx
    }
    assigns = [name: "Bob"]

    template.engine.compile(template)
    {status, html} = template.engine.render(template, assigns)

    assert status === :ok
    assert html === "<html><head><title>Bob</title></head></html>"
  end
end
