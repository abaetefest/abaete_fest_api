defmodule AbaeteFestApi.Config do
  def fetch!(module, key) do
    Confex.fetch_env!(:abaete_fest_api, module) |> Keyword.fetch!(key)
  end

  def callback(config) do
    Confex.Resolver.resolve!(config)
  end

  def env do
    System.get_env("MIX_ENV", "dev")
    |> String.to_atom()
  end
end
