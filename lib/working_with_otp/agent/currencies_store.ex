defmodule WorkingWithOtp.Agent.CurrenciesStore do
  @moduledoc """
  A simple Agent-based store for managing a list of currency codes.

  This module provides functions to start the Agent, add new currency codes,
  retrieve the current list of currency codes, and perform a mock expensive
  operation that simulates processing and extends the list with predefined
  currency codes.
  """
  use Agent

  require Logger

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add_element(currency) do
    Agent.update(__MODULE__, fn state ->
      [currency | state]
    end)
  end

  def get_elements() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def heavy_operation() do
    Logger.info("Doing heavy operation...")
    Process.sleep(4_000)
    Logger.info("Heavy operation finished!")
    ["UYU", "USD", "EUR"]
  end
end
