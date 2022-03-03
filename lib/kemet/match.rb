# frozen_string_literal: true

module Kemet
  class Match
    def add_player(color)
      raise(AlreadyChosenColorError) if players.any? { |player| player.color == color }

      players << Player.new(color)
    end

    def players
      @players ||= []
    end
  end
end
