# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Kemet do
    describe "a 2 player full match" do
      it "works" do
        @events = []
        @listener = proc { |event| p event; @events << event }

        match = Match.new(listener: @listener)
        black_player = match.add_player(:black)
        green_player = match.add_player(:green)

        match.start!

        # p match.current_action

        green_player.add_pyramid(Pyramids::Ruby.new(1), target: :d1)
        green_player.add_pyramid(Pyramids::Diamond.new(2), target: :d2)

        black_player.add_pyramid(Pyramids::Ruby.new(3), target: :d5)

        event_types = @events.map { |e| e[:type] }
        assert_equal %i[action action event], event_types

        # match.next_action #=> Action(type: PlayerAction, player: :green, targets: [])

        # green_player.action(Pray)
      end
    end
  end
end
