defmodule Templates.Engines.EEx.Compiler do
  use GenServer.Behaviour

  @doc """
  Starts the `Templates.Engines.EEx.Compiler` server.
  """
  def start_link(name) do
    :gen_server.start({ :local, name }, __MODULE__, name, [])
  end

  @doc """
  Stops the `Templates.Engines.EEx.Compiler` server.
  """
  def stop(name) do
    :gen_server.call(name, :stop)
  end

  # Callbacks

  def handle_call(:pop, _from, [h|t]) do
    { :reply, h, t }
  end

  def handle_call(request, from, config) do
    # Call the default implementation from GenServer.Behaviour
    super(request, from, config)
  end

  def handle_cast({ :push, item }, config) do
    { :noreply, [item|config] }
  end

  def handle_cast(request, config) do
    super(request, config)
  end
end