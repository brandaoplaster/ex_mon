defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        name: "Lucas",
        life: 100, 
        moves: %{
          move_avg: :punch, move_heal: :heald, move_rnd: :kick
        }
      }
      
      assert expected_response == ExMon.create_player("Lucas", :kick, :punch, :heald)
    end
  end
end
