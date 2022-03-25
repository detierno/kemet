# frozen_string_literal: true

module Kemet
  module Actions # :nodoc:
    class AddPyramid # :nodoc:
      def initialize(player)
        @player = player
        @accumulated_level = 0
      end

      def targets
        @player.city.district_ids
      end

      def interact(match, _player, options)
        district = match.board.areas.find { |a| a.id == options[:target] }
        district.pyramid = options[:pyramid]

        @accumulated_level += options[:pyramid].level
      end

      def name
        "AddPyramid"
      end

      def satisfied?
        @accumulated_level >= 3
      end

      def properties
        { name: name, player: @player.color, targets: targets }
      end

      def to_event
        "#{name} - Player: #{@player.color} - targets: #{targets.join(", ")}"
      end
    end
  end
end
