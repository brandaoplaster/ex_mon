defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

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

  describe "start_game/1" do
    test "when the game is started" do
      player = Player.build("Lucas", :punch, :heald, :kick)

      messages = 
        capture_io(fn -> 
          ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end
end
