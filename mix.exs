defmodule GenStateMachineHelpers.Mixfile do
  use Mix.Project

  def project do
    [
      app: :gen_state_machine_helpers,
      version: "0.1.0",
      elixir: "~> 1.5",
      package: package(),
      docs: [extras: ["README.md"], main: "GenStateMachineHelpers"],
      description: """
      A helper library for GenStateMachine.
      """,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [ maintainers: ["Stephen Pallen"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/smpallen99/gen_state_machine_helpers"},
      files: ~w(lib README.md mix.exs LICENSE)]
  end
end
