defmodule Templates.Template do
  @moduledoc """
  The template record is responsible to keep information about
  templates to be compiled and rendered. It contains:

  - `:key` - The key used to find the template
  - `:source` - The source of the template
  - `:engine` - The template engine responsible for compiling the
    template
  - `:updated_at` - The last time the template was updated
  """

  defstruct key: nil,
            source: nil,
            engine: nil,
            updated_at: nil
end
