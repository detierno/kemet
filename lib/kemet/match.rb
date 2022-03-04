# frozen_string_literal: true

module Kemet
  # Wrapper to generate a match of Kemet board game
  class Match
    attr_reader :di_deck

    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      players << Player.new(color)
    end

    def setup!
      @di_deck = DivineInterventionDeck.cards
    end

    def players
      @players ||= []
    end
  end
end
