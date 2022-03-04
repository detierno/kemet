# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :di_deck, :power_tile_deck

    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      players << Player.new(color)
    end

    def setup!
      @di_deck = Decks::DivineIntervention.new
      @power_tile_deck = Decks::PowerTile.new
    end

    def players
      @players ||= []
    end
  end
end
