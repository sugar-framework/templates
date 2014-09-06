defmodule Templates do
  use Application

  @name :compile_server

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Sugar.Templates.Supervisor.start_link
  end
end
