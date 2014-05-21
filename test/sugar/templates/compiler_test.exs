defmodule Sugar.Templates.CompilerTest do
  use ExUnit.Case
  alias Sugar.Templates.Compiler

  test "stop/0 and stop/1" do
    Compiler.start_link

    assert Compiler.stop === :shutdown_ok
  end

  test "handle_call :get_templates" do
    Compiler.start_link
    {status, templates} = :gen_server.call(:compile_server, :get_templates)

    assert status === :ok
    assert templates === %{}

    Compiler.stop
  end

  test "handle_cast :put_template" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }

    assert :gen_server.cast(:compile_server, {:put_template, template}) === :ok

    Compiler.stop
  end

  test "handle_cast :compile" do
    Compiler.start_link

    template = %Sugar.Templates.Template{
        key: "index.html.eex",
        source: "<html><head><title><%= @name %></title></head></html>",
        engine: Sugar.Templates.Engines.EEx
    }

    assert :gen_server.cast(:compile_server, {:compile, template}) === :ok

    Compiler.stop
  end
end
