defmodule Flightex.Users.UserTest do
  use ExUnit.Case

  alias Flightex.Users.User

  import Flightex.Factory

  describe "build/4" do
    test "When all params are valid, returns the user" do
      {_ok, response} =
        User.build(
          "Deividi",
          "deividi@gmail.com",
          "123456789"
        )

      expected_response = build(:users, id: response.id)

      assert response == expected_response
    end

    test "When cpf is a integer" do
      response =
        User.build(
          "Deividi",
          "deividi@gmail.com",
          111_222_333
        )

      expected_response = {:error, "Cpf must be a String"}

      assert response == expected_response
    end
  end
end
