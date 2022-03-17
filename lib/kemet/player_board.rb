# frozen_string_literal: true

module Kemet
  # Individual board with player actions
  class PlayerBoard
    attr_reader :actions

    Action = Struct.new(:action, :level)

    def initialize
      @actions = []
      init_basic_actions
    end

    def add_action(action, level)
      actions << Action.new(action, level)
    end

    private
      def init_basic_actions
        add_action(PlayerActions::BuyDiamondTile, 1)
        add_action(PlayerActions::BuyRubyTile, 1)
        add_action(PlayerActions::BuySapphireTile, 1)
        add_action(PlayerActions::Pray, 1)
        add_action(PlayerActions::RaisePyramid, 2)
        add_action(PlayerActions::Move, 2)
        add_action(PlayerActions::Pray, 2)
        add_action(PlayerActions::Move, 3)
        add_action(PlayerActions::Recruit, 3)
      end
  end
end
