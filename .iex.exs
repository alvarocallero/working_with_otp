require Logger

defmodule IExHelpers do
  alias WorkingWithOtp.Agent.CurrenciesStore

  def get_state_and_make_a_heavy_operation() do
    Logger.info("Get the current state of the Agent...")
    state = CurrenciesStore.get_elements()
    Logger.info("Doing heavy operation...")
    Logger.info("Another process is modifying the state...")

    Task.start(fn ->
      CurrenciesStore.add_element("USD")
    end)

    Process.sleep(4_000)
    Logger.info("Heavy operation finished!")
    state
  end
end

import_if_available(IExHelpers)
