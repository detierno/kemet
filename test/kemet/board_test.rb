# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Board do
    before do
      @board = Board.new([mock('Player1'), mock('Player2')])
    end

    describe 'for two players' do
      it 'has 13 areas' do
        @board.areas.size.must_equal 13
      end
    end
  end
end
