# frozen_string_literal: true

module Kemet
  module Events
    class MatchSetupCompleted # :nodoc:
      def initialize(match)
        match.turn_order.each { |player| match.add_to_stack(Actions::AddPyramid.new(player)) }
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
