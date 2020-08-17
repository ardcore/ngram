defmodule Ngram.Mixfile do
  use Mix.Project

  def project do
    [app: :ngram,
     version: "0.0.1",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end
  defp description do
    """
    n-gram tokenization and distance calculations
    """
  end

  defp package do
    [# These are the default files included in the package
     maintainers: ["Szymon Pilkowski"],
    collaborators: [
      {"Ivo Nascimento", "https://github.com/iannsp"}
    ],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/ardcore/ngram"}
    ]
  end

  end
