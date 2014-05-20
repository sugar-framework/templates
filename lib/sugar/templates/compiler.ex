defmodule Sugar.Templates.Compiler do
  use GenServer.Behaviour

  @name :compile_server

  @doc """
  Starts the `Templates.Compiler` server.
  """
  def start_link do
    start_link []
  end
  def start_link(args) do
    :gen_server.start({ :local, @name }, __MODULE__, args, [])
  end

  @doc """
  Stops the `Templates.Compiler` server.
  """
  def stop do
    stop(@name)
  end
  def stop(@name) do
    :gen_server.call(@name, :stop)
  end

  # Callbacks

  @doc """
  init our state
  """
  def init(_args) do
    { :ok, %{} }
  end

  @doc """
  grab our templates from the GenServer state
  """
  def handle_call(:get_templates, _from, templates) do
    { :reply, {:ok, templates}, templates }
  end

  @doc """
  add/update a template to the GenServer state
  """
  def handle_cast({:put_template, %Sugar.Templates.Template{} = template}, templates) do
    { :noreply, templates |> Map.put(template.key, template) }
  end

  @doc """
  compile a template via its corresponding engine
  """
  def handle_cast({:compile, %Sugar.Templates.Template{engine: engine} = template}, templates) do
    case engine.compile(template) do
      { :ok, template } -> Sugar.Templates.put_template(template)
      { :error, _ } -> :ok
    end
    { :noreply, templates }
  end
end
