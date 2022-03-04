# frozen_string_literal: true

module Kemet
  module DivineInterventions
    class WarRage # :nodoc:
      def cost
        0
      end

      def effect
        :"+1_attack"
      end

      def phase
        GamePashes::COMBAT
      end
    end
  end
end
