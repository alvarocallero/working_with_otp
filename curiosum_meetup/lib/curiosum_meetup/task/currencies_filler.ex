defmodule CuriosumMeetup.Task.CurrenciesFiller do
  use Task

  require Logger

  alias CuriosumMeetup.Agent.CurrenciesStore

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
