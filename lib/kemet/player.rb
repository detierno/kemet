# frozen_string_literal: true

module Kemet
  # Player represents a contestant for a match
  class Player
    attr_accessor :city
    attr_reader :battle_cards_deck, :color, :player_board, :prayer_points, :match

    def initialize(color, match)
      @color = color
      @battle_cards_deck = Decks::BattleCard.new
      @player_board = PlayerBoard.new
      @prayer_points = 0
      @match = match
    end

    def add_pyramid(pyramid, target:)
      match.interaction(self, pyramid: pyramid, target: target)
    end

    def place_troop(size:, target:)
      troop = Troop.new(self, size)
      match.interaction(self, troop: troop, target: target)
    end
  end
end
