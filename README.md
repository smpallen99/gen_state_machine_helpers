# GenStateMachineHelpers

Helper functions for [gen_state_machine](https://github.com/antipax/gen_state_machine).

Adds `next_state`, `keep_state` functions so you don't have to enter the tuples.

First argument is the data so they fit into a pipeline.

Documentation can be found at [https://hexdocs.pm/gen_state_machine_helpers](https://hexdocs.pm/gen_state_machine_helpers).

## Installation

The package can be installed by adding `gen_state_machine_helpers` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_state_machine_helpers, "~> 0.1.0"}
  ]
end
```

## Usage

Given a state state machine, call the helpers like this example:

```elixir
defmodule StatemLib.Phone do
  use GenStateMachine, callback_mode: :state_functions

  # import this package
  import GenStateMachineHelpers

  require Logger

  def start_link do
    GenStateMachine.start_link __MODULE__, {:initialize, %{}}
  end

  def setup(pid, extension, id) do
    GenStateMachine.cast pid, {:setup, extension, id}
  end

  def call(pid, extension) do
    GenStateMachine.call pid, {:call, extension}
  end

  def hangup(pid) do
    GenStateMachine.call pid, :hangup
  end

  def get_status(pid) do
    GenStateMachine.call pid, :get_status
  end

  def initialize(:cast, {:setup, extension, id}, data) do
    data
    |> Map.put(:id, id)
    |> Map.put(:extension, extension)
    |> next_state(:idle)
  end

  def initialize(event_type, event_content, data) do
    handle_event(event_type, event_content, data)
  end

  def idle({:call, from}, {:call, extension}, data) do
    data
    |> Map.put(:dest_extension, extension)
    |> next_state(:calling, [{:reply, from, {:calling, extension}}])
  end

  def idle(event_type, event_content, data) do
    handle_event(event_type, event_content, data)
  end

  def calling(event_type, event_content, data) do
    handle_event(event_type, event_content, data)
  end

  def handle_event({:call, from}, :get_status, data) do
    keep_state, date, [{:reply, from, data}]
  end

  def handle_event({:call, from}, :hangup, data) do
    data
    |> Map.delete(:dest_extension)
    |> next_state(:idle, [{:reply, from, :idle}])
  end

  def handle_event(a, b, data) do
    keep_state data
  end
end
```

## License

ex_ami is Copyright (c) 2017 Stephen Pallen

The source code is released under the MIT License.

Check [LICENSE](LICENSE) for more information.
