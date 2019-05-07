defmodule Sugar.Templates do
  @name :compile_server

  @doc """
  Compiles a single template or a list of templates.
  """
  def compile(templates) when is_list(templates) do
    Enum.map templates, &compile(&1)
  end
  def compile(%Sugar.Templates.Template{} = template) do
    key = template.key |> String.replace("/", "_")
    current = get_template key

    if current == nil || current.updated_at < template.updated_at do
      :gen_server.cast(@name, { :compile, %{ template | key: key } })
    else
      :ok
    end
  end

  @doc """
  Gets all stored structs of compiled templates via a GenServer cast.
  """
  def get_all_templates do
    {:ok, templates} = :gen_server.call(@name, :get_templates)
    templates
  end

  @doc """
  Gets a template from a stored map of structs of compiled templates.
  """
  def get_template(key) do
    get_all_templates()
      |> Map.get(key)
  end

  @doc """
  Puts a template into a stored map of structs of compiled templates via a GenServer cast.
  """
  def put_template(template) do
    :gen_server.cast(@name, { :put_template, template })
  end

  def render(%Sugar.Templates.Template{} = template, assigns) do
    { :ok, html } = template.engine.render template, assigns
    html
  end
  def render(key, assigns) do
    # Sanity check.  If we get an error tuple instead of a key, don't let it get
    # shoved into String.replace/4 or confusingly-bad things will happen.
    if key == {:error, :notfound} do
      raise "Template not found"
    end
    template = key
      |> String.replace("/", "_")
      |> get_template
    { :ok, html } = template.engine.render template, assigns

    html
  end
end
