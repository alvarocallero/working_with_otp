require Logger

defmodule IExHelpers do
  alias WorkingWithOtp.Agent.CurrenciesStore

  def get_state_and_make_a_heavy_operation() do
    state = CurrenciesStore.get_elements()
    Logger.info("Doing heavy operation...")
    add_new_element_to_agent()
    Process.sleep(4_000)
    Logger.info("Heavy operation finished!")
    state
  end

  def add_new_element_to_agent() do
    Logger.info("Another process is modifying the state...")

    Task.start(fn ->
      CurrenciesStore.add_element("USD")
    end)
  end

  def get_agent_state() do
    CurrenciesStore.get_elements()
  end
end

import_if_available(IExHelpers)
