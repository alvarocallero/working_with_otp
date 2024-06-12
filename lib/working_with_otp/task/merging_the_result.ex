defmodule WorkingWithOtp.Task.MergingTheResult do
  @moduledoc """
  This module handles fetching currency data from various sources concurrently,
  merges the results, and stores them in an Agent.
  It demonstrates the use of asynchronous tasks to retrieve data from different sources, and processes this data efficiently.
  """
  require Logger

  alias WorkingWithOtp.Agent.CurrenciesStore

  def fetch_currencies() do
    tasks = [
      Task.async(fn -> get_currencies_from_database() end),
      Task.async(fn -> get_currencies_reading_file_on_disk() end),
      Task.async(fn -> get_currencies_from_api_call() end)
    ]

    tasks
    |> Task.await_many()
    |> merge_currencies()
    |> store_currencies_in_agent()
  end

  defp merge_currencies(currencies_lists) do
    Logger.info("Merging currencies")
    List.flatten(currencies_lists)
  end

  defp get_currencies_from_database() do
    Process.sleep(3_000)
    ["USD", "EUR", "CAD"]
  end

  defp get_currencies_reading_file_on_disk() do
    Process.sleep(3_000)
    ["UYU", "ARS", "BRL"]
  end

  defp get_currencies_from_api_call() do
    Process.sleep(3_000)
    ["NZD", "BRL", "JPY"]
  end

  defp store_currencies_in_agent(currencies) do
    Logger.info("Storing currencies in Agent")
    Enum.each(currencies, &CurrenciesStore.add_element/1)
  end
end
