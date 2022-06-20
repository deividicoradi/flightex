defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(
        %NaiveDateTime{} = complete_date,
        local_origin,
        local_destination,
        user_id
      ) do
    {:ok, build_booking(complete_date, local_origin, local_destination, user_id, UUID.uuid4())}
  end

  def build(
        %NaiveDateTime{} = complete_date,
        local_origin,
        local_destination,
        user_id,
        id
      ) do
    {:ok, build_booking(complete_date, local_origin, local_destination, user_id, id)}
  end

  def build(
        _complete_date,
        _local_origin,
        _local_destination,
        _user_id,
        _id \\ :default
      ),
      do: {:error, "Invalid params"}

  defp build_booking(complete_date, local_origin, local_destination, user_id, id) do
    %__MODULE__{
      complete_date: complete_date,
      local_origin: local_origin,
      local_destination: local_destination,
      user_id: user_id,
      id: id
    }
  end
end
