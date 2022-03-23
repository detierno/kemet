# frozen_string_literal: true

module Kemet
  module Actions # :nodoc:
    class AddPyramid # :nodoc:
      def initialize(player)
        @player = player
      end

      def targets
        @player.city.district_ids
      end

      def interact(match, _player, options)
        district = match.board.areas.find { |a| a.id == options[:target] }
        district.pyramid = options[:pyramid]
      end

      def inspect
        "Actions::AddPyramid.#{@player.inspect} targets: #{targets}"
      end
    end
  end
end
