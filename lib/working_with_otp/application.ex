defmodule WorkingWithOtp.Application do
  @moduledoc false

  use Application

  def application do
    [applications: [:con_cache]]
  end

  @impl true
  def start(_type, _args) do
    children = [
      {ConCache,
       [
         name: :currencies_cache,
         ttl_check_interval: false
       ]},
      # Agent ---------------------------------------------------------------
      # WorkingWithOtp.Agent.CurrenciesStore

      # Task ---------------------------------------------------------------
      # WorkingWithOtp.Task.CurrenciesFiller,
      # {Task.Supervisor, name: TaskSupervisor}

      # GenServer ---------------------------------------------------------------
      # WorkingWithOtp.GenServer.CurrenciesStore
      # WorkingWithOtp.GenServer.CurrenciesStoreWithPostInitialization
      # WorkingWithOtp.GenServer.CurrenciesStoreWithPostInitializationMoreSteps
    ]

    opts = [strategy: :one_for_one, name: WorkingWithOtp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
