# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Kemet do
    describe "a 2 player full match" do
      it "works" do
        @events = []
        @listener = proc { |e| @events << "#{e[:type]}: #{e[:event]}" }

        match = Match.new(listener: @listener)
        black_player = match.add_player(:black)
        green_player = match.add_player(:green)

        match.players.expects(:shuffle!).returns([black_player, green_player])

        match.start!

        district = match.current_action_properties[:targets].first
        black_player.add_pyramid(Pyramids::Ruby.new(3), target: district)

        d1, d2 = match.current_action_properties[:targets]

        green_player.add_pyramid(Pyramids::Ruby.new(1), target: d1)
        green_player.add_pyramid(Pyramids::Diamond.new(2), target: d2)

        assert_equal expected_events, @events
      end

      def expected_events
        [
          "stack_added: AddPyramid - Player: black - targets: d2, d3, d1",
          "stack_added: AddPyramid - Player: green - targets: d5, d6, d4",
          "event: Match setup completed",
          "current_action_changed: AddPyramid - Player: black - targets: d2, d3, d1",
          "action_performed: AddPyramid - Player: black - targets: d2, d3, d1",
          "current_action_changed: AddPyramid - Player: green - targets: d5, d6, d4",
          "action_performed: AddPyramid - Player: green - targets: d5, d6, d4",
          "action_performed: AddPyramid - Player: green - targets: d5, d6, d4"
        ]
      end
    end
  end
end
