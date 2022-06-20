defmodule Flightex.Users.CreateOrUpdateTest do
  use ExUnit.Case, async: true

  alias Flightex.Users.{Agent, CreateOrUpdate}

  describe "call/1" do
    setup do
      Agent.start_link(%{})
      # O Agent.start_link vai iniciar os 2 agents antes do teste
      # Deve ser implementado para os testes passarem
      :ok
    end

    test "When all params are valid, return a tuple" do
      params = %{
        name: "Deividi",
        email: "deividi@gmail.com",
        cpf: "123456789"
      }

      CreateOrUpdate.call(params)

      {_ok, response} = Agent.get(params.cpf)

      expected_response = %Flightex.Users.User{
        cpf: "123456789",
        email: "deividi@gmail.com",
        id: response.id,
        name: "Deividi"
      }

      assert response == expected_response
    end

    test "When cpf is a integer, returns an error" do
      params = %{
        name: "Deividi",
        email: "deividi@gmail.com",
        cpf: 123_456_789
      }

      expected_response = {:error, "Cpf must be a String"}

      response = CreateOrUpdate.call(params)

      assert response == expected_response
    end
  end
end
