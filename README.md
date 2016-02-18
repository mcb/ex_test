# ExTest

Wrapper around ExUnit to support BBD (rspec) like syntax. It aims to be as lightweight as possible and keep the functionality of ExUnit.
Any options passed to ExTest will be passed on to `ExUnit.Case` (e.g. `async: true`). It is right now in an alpha state, however it is improved over time as it is actively used within a bigger project.


## Pull requests
Pull requests to improve this software are very welcome. However please note, that this should not be considered as a `rspec` clone, so please keep this in mind when developing features. Thanks!


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add ex_test to your list of dependencies in `mix.exs`:

        def deps do
          [{:ex_test, "~> 0.0.1"}]
        end

  2. Ensure ex_test is started before your application:

        def application do
          [applications: [:ex_test]]
        end

