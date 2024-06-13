defmodule WorkingWithOtp.Task.CurrenciesFiller do
  @moduledoc """
  This module is responsible for fetching a list of currency codes from a database (simulate) and storing them in an Agent.
  It uses the `Task` behaviour to run asynchronously and logs its operations.
  The goal of this Task is to be executed at the application startup to backfill the currencies in the Agent state.
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
