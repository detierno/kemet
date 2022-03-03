# frozen_string_literal: true

module Kemet
  # Player represents a contestant for a match
  class Player
    attr_reader :color

    def initialize(color)
      @color = color
    end
  end
end
