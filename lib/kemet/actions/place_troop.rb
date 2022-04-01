# frozen_string_literal: true

module Kemet
  module Actions # :nodoc:
    class PlaceTroop # :nodoc:
      def initialize(player, troop_size)
        @player = player
        @troop_size = troop_size
      end

      def targets
        @player.city.district_ids
      end

      def interact(match, _player, options)
        area = match.board.areas.find { |a| a.id == options[:target] }
        area.troop = options[:troop]
      end

      def name
        "PlaceTroop"
      end

      def satisfied?
        true
      end

      def properties
        { name: name, player: @player.color, targets: targets }
      end

      def to_event
        "#{name} - Player: #{@player.color} - targets: #{targets.join(", ")} - troop_size: #{@troop_size}"
      end
    end
  end
end
