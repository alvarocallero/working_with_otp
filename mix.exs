defmodule WorkingWithOtp.MixProject do
  use Mix.Project

  def project do
    [
      app: :working_with_otp,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {WorkingWithOtp.Application, []}
    ]
  end

  defp deps do
    [
      {:libcluster, "~> 3.3"},
      {:con_cache, "~> 1.1"}
    ]
  end
end
