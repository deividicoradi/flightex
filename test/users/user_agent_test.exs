defmodule Flightex.Users.AgentTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Users.Agent, as: UserAgent

  describe "save/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()
      cpf = "123456789"

      {:ok, id: id, cpf: cpf}
    end

    test "When the user is saves, returns an tuple", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: cpf, email: "deividi@gmail.com", id: id, name: "Deividi"}}

      assert response == expected_response
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      id = UUID.uuid4()
      cpf = "12345678900"

      {:ok, id: id, cpf: cpf}
    end

    test "When the user is found, returns the user", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok, %Flightex.Users.User{cpf: cpf, email: "deividi@gmail.com", id: id, name: "Deividi"}}

      assert response == expected_response
    end

    test "When the user is't founded, returns an error", %{id: id, cpf: cpf} do
      :users
      |> build(id: id, cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get("banana")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
