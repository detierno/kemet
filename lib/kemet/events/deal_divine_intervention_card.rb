# frozen_string_literal: true

module Kemet
  module Events
    class DealDivineInterventionCard # :nodoc:
      def initialize(match, player, quantity)
        @match = match
        @quantity = quantity
        @player = player
      end

      def call
        @quantity.times do
          card = @match.draw_di_card
          @player.receive_di_card(card)
        end
      end

      def name
        "DI card received - Player: #{@player.color} - quantity: #{@quantity}"
      end
      alias to_event name

      def properties
        { name: name }
      end
    end
  end
end
