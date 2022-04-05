# frozen_string_literal: true

module Kemet
  module Events
    class NewRound # :nodoc:
      attr_reader :round

      def initialize(match)
        player_turns = match.turn_order.cycle

        @round = Match::Round.new(match: match)
        @player = player_turns.next

        match.add_to_stack(Actions::PlayerAction.new(@player))
      end

      def name
        "New game round"
      end
      alias to_event name

      def properties
        { name: name }
      end
    end
  end
end
