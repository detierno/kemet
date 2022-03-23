# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Player do
    describe "#initialize" do
      before do
        @player = Player.new(:red, mock("Match"))
      end

      it "set the player color" do
        assert_equal :red, @player.color
      end

      it "initialize a Decks::BattleCard" do
        Decks::BattleCard.expects(:new).once
        Player.new(:red, mock("Match"))
      end

      it "set to @battle_cards_deck variable" do
        refute_nil @player.battle_cards_deck
      end

      it "initialize a PlayerBoard" do
        PlayerBoard.expects(:new).once
        Player.new(:red, mock("Match"))
      end

      it "set to @player_board variable" do
        refute_nil @player.player_board
      end
    end
  end
end
