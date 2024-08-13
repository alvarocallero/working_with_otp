require Logger

defmodule IExHelpers do
  alias WorkingWithOtp.Agent.CurrenciesStore

  def get_state_and_make_a_heavy_operation() do
    Logger.info("Getting the current state of the Agent... | #{inspect(self())}")
    state = CurrenciesStore.get_elements()
    Logger.info("Doing heavy operation... | #{inspect(self())}")

    Task.start(fn ->
      Logger.info("Another process is modifying the state... | #{inspect(self())}")
      CurrenciesStore.add_element("USD")
    end)

    Process.sleep(4_000)
    Logger.info("Heavy operation finished!  | #{inspect(self())}")
    state
  end
end

import_if_available(IExHelpers)
