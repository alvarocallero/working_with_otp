defmodule WorkingWithOtp.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Agent --------------------------------------------------------------
      WorkingWithOtp.Agent.CurrenciesStore,

      # Task ---------------------------------------------------------------
      {Task.Supervisor, name: TaskSupervisor},

      # GenServer ----------------------------------------------------------
      WorkingWithOtp.GenServer.CurrenciesStore
      # WorkingWithOtp.GenServer.CurrenciesStoreWithPostInitialization
    ]

    opts = [strategy: :one_for_one, name: WorkingWithOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
