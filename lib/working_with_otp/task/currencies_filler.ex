defmodule WorkingWithOtp.Task.CurrenciesFiller do
  @moduledoc """
  This module is responsible for fetching a list of currency codes from a database (simulate) and storing them in an Agent.
  It uses the `Task` behaviour to run asynchronously and logs its operations.

  The main functions are:
  - `start_link/1`: Starts the task with the given argument.
  - `run/1`: Fetches the currency codes and stores them in the Agent.
  - `get_currencies_from_database/0`: Retrieves a list of currency codes from the database (simulated).
  - `store_currencies_in_agent/1`: Stores each currency code in the Agent by invoking the `CurrenciesStore` module.
  """

  use Task

  require Logger

  alias WorkingWithOtp.Agent.CurrenciesStore

  def start_link(arg) do
    Task.start_link(__MODULE__, :run, [arg])
  end

  def run(_arg) do
    currencies = get_currencies_from_database()
    store_currencies_in_agent(currencies)
  end

  defp get_currencies_from_database() do
    Logger.info("Getting currencies from database")
    ["UYU", "USD", "CAD", "EUR", "MXN"]
  end

  defp store_currencies_in_agent(currencies) do
    Logger.info("Storing currencies in agent")

    Enum.each(currencies, fn currency ->
      CurrenciesStore.add_element(currency)
    end)
  end
end
