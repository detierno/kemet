# frozen_string_literal: true

module Kemet
  module DivineInterventions
    class WarFury
      def cost
        1
      end

      def effect
        :"+2_attack"
      end

      def phase
        GamePashes::COMBAT
      end
    end
  end
end
