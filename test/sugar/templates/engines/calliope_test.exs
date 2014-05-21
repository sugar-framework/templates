defmodule Sugar.Templates.Engines.CalliopeTest do
  use ExUnit.Case

  test "render/2" do
    template = %Sugar.Templates.Template{
      key: "index.html.haml",
      source: "!!! 5\n%html{lang: \"en-US\"}",
      engine: Sugar.Templates.Engines.Calliope
    }
    {status, html} = template.engine.render(template, [])

    assert status === :ok
    assert html === "<!DOCTYPE html><html lang=\"en-US\"></html>"
  end
end
