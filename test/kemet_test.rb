# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Kemet do
    describe "a 2 player full match" do
      it "works" do
        match = Match.new(logger: Logger.new(nil))
        _black_player = match.add_player(:black)
        green_player = match.add_player(:green)

        match.setup!

        match.waiting_action?

        match.next_action!

        match.current_action

        green_player.add_pyramid(Pyramids::Ruby.new(1), target: :d1)

        green_player.add_pyramid(Pyramids::Diamond.new(2), target: :d2)

        # match.next_action! #=> Action(type: AddPyramid, player: :green, targets: [Area1, Area2, Area3])

        # match.current_action_fullfiled? #=> false

        # green_player.action(AddPyramid.new(:diamond, level: 2, target: Area2))

        # match.current_action_fullfiled? #=> true

        # match.next_action #=> Action(type: AddPyramid, player: :black, targets: [Area6, Area7, Area8])

        # black_player.action(AddPyramid.new(:diamond, level: 1, target: Area6))
        # black_player.action(AddPyramid.new(:diamond, level: 1, target: Area7))
        # black_player.action(AddPyramid.new(:diamond, level: 1, target: Area8))

        # match.next_action #=> nil

        # match.start! # ???

        # match.next_action #=> Action(type: PlayerAction, player: :green, targets: [])

        # green_player.action(Pray)
      end
    end
  end
end
