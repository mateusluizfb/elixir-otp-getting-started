defmodule KV.MixProject do
  use Mix.Project

  def project do
    [
      app: :kv,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def set_application(:test) do
    [
      extra_applications: [:logger],
    ]
  end

  def set_application(_) do
    [
      extra_applications: [:logger],
      mod: {KV, []}
    ]
  end


  # Run "mix help compile.app" to learn about applications.
  def application do
    set_application(Mix.env())
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mock, "~> 0.3.0", only: :test}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
