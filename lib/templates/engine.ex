defmodule Templates.Engine do
  @moduledoc """
  Specification of the template engine API implemented 
  by engines.
  """
  use Behaviour

  @type template :: Templates.Template.t
  @type reason   :: String.t
  @type vars     :: list | Keyword.t

  @doc """
  Compiles a `template`.

  It is advised that an engine implementation removes the tremplate
  source from the record if it is not needed after compilation but
  retain it if needed for rendering.
  """
  defcallback compile(template) :: {:ok, template} | {:error, reason}

  @doc """
  Renders a compiled template based on the given `template` record.
  """
  defcallback render(template, vars) :: {:ok, iodata}
end