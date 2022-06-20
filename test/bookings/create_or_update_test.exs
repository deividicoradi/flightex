defmodule Flightex.Bookings.CreateOrUpdateTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.{Agent, CreateOrUpdate}

  describe "call/1" do
    setup do
      Agent.start_link(%{})

      :ok
    end

    test "When all params are valid, returns a valid tuple" do
      params = %{
        complete_date: ~N[2022-06-20 11:24:00],
        local_origin: "Porto Alegre",
        local_destination: "Curitiba",
        user_id: "123456789",
        id: UUID.uuid4()
      }

      {_ok, uuid} = CreateOrUpdate.call(params)

      {_ok, response} = Agent.get(uuid)

      expected_response = %Flightex.Bookings.Booking{
        id: response.id,
        complete_date: ~N[2022-06-20 11:24:00],
        local_destination: "Curitiba",
        local_origin: "Porto Alegre",
        user_id: "123456789"
      }

      assert response == expected_response
    end
  end
end
