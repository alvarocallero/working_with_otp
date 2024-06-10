defmodule WorkingWithOtp.Agent.CurrenciesStore do
  @moduledoc """
  A simple Agent-based store for managing a list of currency codes.

  This module provides functions to start the Agent, add new currency codes,
  retrieve the current list of currency codes, and perform a mock expensive
  operation that simulates processing and extends the list with predefined
  currency codes.

  ## Functions

    * `start_link/1` - Starts the Agent with an initial empty list.
    * `add_element/1` - Adds a new currency code to the list.
    * `get_elements/0` - Retrieves the current list of currency codes.
    * `do_something_expensive/1` - Simulates an expensive operation by sleeping
      for 4 seconds and then appending a list of predefined currency codes to the
      current state.
  """

  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_element(message) do
    Agent.update(__MODULE__, fn state ->
      [message | state]
    end)
  end

  def get_elements() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def do_something_expensive(state) do
    Process.sleep(4000)
    state ++ ["UYU", "USD", "EUR", "GBP", "ARS"]
  end
end
