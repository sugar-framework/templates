defmodule Templates do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Templates.Supervisor.start_link
  end
end

defrecord Templates.Template,
  key: nil,
  source: nil,
  engine: nil,
  updated_at: nil do
  @moduledoc """
  The template record is responsible to keep information about
  templates to be compiled and rendered. It contains:

  - `:key` - The key used to find the template
  - `:source` - The source of the template
  - `:engine` - The template engine responsible for compiling the 
    template
  - `:updated_at` - The last time the template was updated
  """

  @type key        :: atom
  @type source     :: iodata
  @type engine     :: module
  @type year       :: pos_integer
  @type month      :: 1..12
  @type day        :: 1..31
  @type hour       :: 0..24
  @type minute     :: 0..60
  @type second     :: 0..60
  @type datetime   :: {{ year, month, day }, { hour, minute, second }}
  @type updated_at :: datetime

  record_type key: key,
              source: source,
              engine: engine,
              updated_at: updated_at
end