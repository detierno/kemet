# frozen_string_literal: true

module Kemet
  module PowerTiles
    module Ruby
      class Charge # :nodoc:
        def name
          "Charge!"
        end

        def level
          1
        end

        def description
          "In Battle, when you are the attacker, your Troops gain +1 Strength."
        end

        def phase
          :day
        end

        def effect
          :"+1_attack"
        end

        def condition
          "attacking"
        end
      end
    end
  end
end
