defmodule Flightex.Factory do
  use ExMachina

  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def users_factory do
    %User{
      id: UUID.uuid4(),
      name: "Deividi",
      email: "deividi@gmail.com",
      cpf: "123456789"
    }
  end

  def booking_factory do
    %Booking{
      complete_date: ~N[2022-06-20 11:25:00],
      local_origin: "Porto Alegre",
      local_destination: "Curitiba",
      user_id: "123456789",
      id: UUID.uuid4()
    }
  end
end
