defmodule Sugar.TemplatesTest do
  use ExUnit.Case, async: false
  alias Sugar.Templates.Compiler

  test "compile/1 with list" do
    Compiler.start_link

    templates = [ %Sugar.Templates.Template{
                      key: "index.html.eex",
                      source: "<html><head><title><%= @name %></title></head></html>",
                      engine: Sugar.Templates.Engines.EEx
                  },
                  %Sugar.Templates.Template{
                      key: "show.html.eex",
                      source: "<html><head><title><%= @name %></title></head></html>",
                      engine: Sugar.Templates.Engines.EEx
                  } ]

    compile_statuses = Sugar.Templates.compile(templates)

    assert compile_statuses === [:ok, :ok]

    Compiler.stop
  end

  test "compile/1 with template" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }

    compile_status = Sugar.Templates.compile(template)

    assert compile_status === :ok

    Compiler.stop
  end

  test "get_all_templates/0" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }
    expected = %{ "index.html.eex" => template }

    put_status = Sugar.Templates.put_template(template)
    templates = Sugar.Templates.get_all_templates

    assert put_status === :ok
    assert templates === expected

    Compiler.stop
  end

  test "get_template/1" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }

    assert Sugar.Templates.put_template(template) === :ok
    assert Sugar.Templates.get_template(template.key) === template

    Compiler.stop
  end

  test "put_template/1" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }

    assert Sugar.Templates.put_template(template) === :ok

    Compiler.stop
  end

  test "render/2 with template" do
      Compiler.start_link

      template = %Sugar.Templates.Template{
          key: "index.html.eex",
          source: "<html><head><title><%= @name %></title></head></html>",
          engine: Sugar.Templates.Engines.EEx
      }
      assigns = [name: "Bob"]

      compile_status = Sugar.Templates.compile(template)
      html = Sugar.Templates.render(template, assigns)

      assert compile_status === :ok
      assert html === "<html><head><title>Bob</title></head></html>"

      Compiler.stop
  end

  test "render/2 with key" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }
    assigns = [name: "Bob"]

    template.engine.compile(template)
    compile_status = :gen_server.cast(:compile_server, {:put_template, template})
    html = Sugar.Templates.render("index.html.eex", assigns)

    assert compile_status === :ok
    assert html === "<html><head><title>Bob</title></head></html>"

    Compiler.stop
  end
end
