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

    def inspect
      "<#{color} player>"
    end

    def receive_event(event)
      # "Event received: #{inspect} #{event.inspect}"
    end
  end
end
