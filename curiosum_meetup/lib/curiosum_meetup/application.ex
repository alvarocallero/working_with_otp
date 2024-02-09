defmodule CuriosumMeetup.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: CuriosumMeetup.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
