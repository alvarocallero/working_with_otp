defmodule CuriosumMeetup.Agent.CurrenciesStore do
  use Agent

  @default_name CuriosumMeetup.Agent.CurrenciesStore

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: @default_name)
  end

  def add_element(name \\ @default_name, message) do
    Agent.update(name, fn state ->
      [message | state]
    end)
  end

  def get_elements(name \\ @default_name) do
    Agent.get(name, fn state -> state end)

  end

  def do_something_expensive(state) do
    Process.sleep(4000)
    # ["UYU", "USD", "EUR", "GBP", "ARS"]
    state
  end


end
