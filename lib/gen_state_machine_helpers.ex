defmodule GenStateMachineHelpers do
  @moduledoc """
  Helpers for GenStateMachine.

  Replace those ugly return tuples with function calls.

  The first argument is the data so they can be easily place in a pipeline.

  For example:

      def handle_event(:cast, {:add, num}, data) do
        data
        |> update_in([:num], & &1 + num)
        |> keep_state
      end
  """

  @doc """
  Return the next_state tuple.

  ## Examples

      iex> GenStateMachineHelpers.next_state(%{}, :idle)
      {:next_state, :idle, %{}}

  """
  @spec next_state(any, atom) :: {:next_state, atom, any}
  def next_state(data, state_name) do
    {:next_state, state_name, data}
  end

  @doc """
  Return the next_state tuple with a reply tuple.

  ## Examples

      iex> GenStateMachineHelpers.next_state(%{}, :idle, [{:reply, :from, :result}])
      {:next_state, :idle, %{}, [{:reply, :from, :result}]}

  """
  @spec next_state(any, atom, any) :: {:next_state, atom, any, any}
  def next_state(data, state_name, reply) do
    {:next_state, state_name, data, reply}
  end

  @doc """
  Return the keep_state tuple.

  ## Examples

      iex> GenStateMachineHelpers.keep_state(%{})
      {:keep_state, %{}}

  """
  @spec keep_state(any) :: {:keep_state, any}
  def keep_state(data) do
    {:keep_state, data}
  end

  @doc """
  Return the keep_state tuple with a reply tuple.

  ## Examples

      iex> GenStateMachineHelpers.keep_state(%{}, [{:reply, :from, :result}])
      {:keep_state, %{}, [{:reply, :from, :result}]}

  """
  @spec keep_state(any, any) :: {:keep_state, any, any}
  def keep_state(data, reply) do
    {:keep_state, data, reply}
  end
end
