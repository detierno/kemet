# frozen_string_literal: true

module Kemet
  module Events
    class MatchSetupCompleted # :nodoc:
      def initialize(match)
        match.turn_order.each do |player|
          # match.add_to_stack(Events::DealDivineInterventionCard.new(player, 2))
          match.add_to_stack(Actions::AddPyramid.new(player))
          2.times { match.add_to_stack(Actions::PlaceTroop.new(player, 5)) }
        end
      end

      def name
        "Match setup completed"
      end
      alias to_event name

      def properties
        { name: name }
      end
    end
  end
end
