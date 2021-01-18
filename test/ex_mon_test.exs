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

  describe "make_move/1" do
    setup do
      player = Player.build("Lucas", :punch, :heald, :kick)
      capture_io(fn -> ExMon.start_game(player) end)
      :ok
    end

    test "when the move is valid, do the move an the computer makes a move" do
      messages =
        capture_io(fn -> 
          ExMon.make_move(:heald)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "Its computer turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn -> 
          ExMon.make_move(:move_not)
        end)

      assert messages =~ "Invalid move: move_not"   
    end
  end
end
