# frozen_string_literal: true

require "test_helper"

module Kemet
  class PlayerTest < Minitest::Test
    class InitializePlayerTest < PlayerTest
      def setup
        @player = Player.new(:red, mock("Match"))
      end

      def test_set_player_color
        assert_equal :red, @player.color
      end

      def test_set_player_battle_card_deck
        Decks::BattleCard.expects(:new).once
        Player.new(:red, mock("Match"))
      end

      def test_set_battle_card_deck
        refute_nil @player.battle_cards_deck
      end

      def test_set_player_board
        PlayerBoard.expects(:new).once
        Player.new(:red, mock("Match"))
      end

      def test_player_board_variable
        refute_nil @player.player_board
      end
    end
  end

  class AddPyramidTest < PlayerTest
    def test_add_pyramid_calls_match_interaction
      match = mock("Match")
      player = Player.new(:red, match)

      match
        .expects(:interaction)
        .with(player, pyramid: "Pyramid", target: "target")
        .once

      player.add_pyramid("Pyramid", target: "target")
    end
  end
end
