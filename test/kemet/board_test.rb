# frozen_string_literal: true

require "test_helper"

module Kemet
  describe Board do
    before do
      @areas = Board.new([mock("Player1"), mock("Player2")]).areas
    end

    describe "for two players" do
      it "has 13 areas" do
        _(@areas.size).must_equal 13
      end

      it "set 6 districts" do
        districts  = @areas.select { |a| a.is_a?(Areas::District) }
        _(districts.size).must_equal 6
      end

      it "set 4 deserts" do
        districts  = @areas.select { |a| a.is_a?(Areas::Desert) }
        _(districts.size).must_equal 4
      end

      it "set 3 sanctuaries" do
        districts  = @areas.select { |a| a.is_a?(Areas::Sanctuary) }
        _(districts.size).must_equal 3
      end
    end
  end
end
