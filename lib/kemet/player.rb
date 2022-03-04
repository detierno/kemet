# frozen_string_literal: true

module Kemet
  # Player represents a contestant for a match
  class Player
    attr_reader :battle_cards_deck, :color, :player_board

    def initialize(color)
      @color = color
      @battle_cards_deck = Decks::BattleCard.new
      @player_board = PlayerBoard.new
    end
  end
end
