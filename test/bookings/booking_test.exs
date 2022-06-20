defmodule Flightex.Bookings.BookingTest do
  use ExUnit.Case, async: false

  alias Flightex.Bookings.Booking

  describe "build/4" do
    test "When all params are valid, returns a booking" do
      {_ok, response} =
        Booking.build(
          ~N[2022-06-20 11:24:00],
          "Porto Alegre",
          "Curitiba",
          "123456789"
        )

      expected_response = %Flightex.Bookings.Booking{
        complete_date: ~N[2022-06-20 11:24:00],
        id: response.id,
        local_destination: "Curitiba",
        local_origin: "Porto Alegre",
        user_id: "123456789"
      }

      assert response == expected_response
    end

    test "When a complete_date is invalid, return a error" do
      response =
        Booking.build(
          "2022-06-20 11:24:00",
          "Porto Alegre",
          "Curitiba",
          "123456789"
        )

      expected_response = {:error, "Invalid params"}

      assert response == expected_response
    end
  end
end
