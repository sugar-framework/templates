defmodule Sugar.Templates.TemplateTest do
  use ExUnit.Case

  test "__struct__" do
    template = %Sugar.Templates.Template{
      key: "main/index.html.eex",
      source: "<%= 2 + 2 %>",
      binary: nil,
      engine: Sugar.Templates.Engines.EEx,
      updated_at: {{2014, 05, 02}, {22, 41, 00}}
    }

    assert template.key === "main/index.html.eex"
    assert template.source === "<%= 2 + 2 %>"
    assert template.engine === Sugar.Templates.Engines.EEx
    assert template.updated_at === {{2014, 05, 02}, {22, 41, 00}}
  end
end
