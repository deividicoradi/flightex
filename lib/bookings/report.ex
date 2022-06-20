defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate(file_name \\ "report.csv") do
    booking_list = build_booking_list()
    File.write!(file_name, booking_list)
  end

  def generate_report(%Date{} = from_date, %Date{} = to_date) do
    {:ok,
     BookingAgent.get_all()
     |> Map.values()
     |> Enum.filter(fn elem -> Date.compare(elem.complete_date, from_date) in [:eq, :gt] end)
     |> Enum.filter(fn elem -> Date.compare(elem.complete_date, to_date) in [:eq, :lt] end)
     |> Enum.map(fn booking -> booking_to_string(booking) end)}
  end

  defp build_booking_list do
    BookingAgent.get_all()
    |> Map.values()
    |> Enum.map(fn booking -> booking_to_string(booking) end)
  end

  defp booking_to_string(%Booking{
         complete_date: complete_date,
         local_origin: local_origin,
         local_destination: local_destination,
         user_id: user_id
       }) do
    "#{user_id}, #{local_origin}, #{local_destination},#{complete_date}"
  end
end
