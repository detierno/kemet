module Kemet
  module PowerTiles
    class Charge
      name 'Charge!'
      level 1
      description 'In Battle, when you are the attacker, your Troops gain +1 Strength.'
      phase :day
      color :red

      attack_modifier '+1'

      condition 'attacking'
    end
  end
end
