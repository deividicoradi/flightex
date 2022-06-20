# Este teste é opcional, mas vale a pena tentar e se desafiar 😉

defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  alias Flightex.Bookings.Report

  describe "generate/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params = %{
        complete_date: ~N[2022-06-20 11:24:00],
        local_origin: "Porto Alegre",
        local_destination: "Curitiba",
        user_id: "123456789",
        id: UUID.uuid4()
      }

      content = "123456789, Porto Alegre, Curitiba,2022-06-20 11:24:00"

      Flightex.create_or_update_booking(params)
      Report.generate("report_test.csv")
      {_ok, file} = File.read("report_test.csv")

      assert file =~ content
    end
  end
end
