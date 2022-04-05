# frozen_string_literal: true

module Kemet
  module Actions # :nodoc:
    class PlayerAction # :nodoc:
      def initialize(player)
        @player = player
      end

      def targets; end

      def interact(match, _player, options); end

      def name
        "PlayerAction"
      end

      def satisfied?; end

      def properties
        { name: name, player: @player.color, targets: targets }
      end

      def to_event
        "#{name} - Player: #{@player.color}"
      end
    end
  end
end
