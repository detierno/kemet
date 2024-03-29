# frozen_string_literal: true

require "ostruct"
require "test_helper"

module Kemet
  MockPlayer = OpenStruct

  EXPECTED_CONNECTIONS = {
    d1: %i[d2 d3 t1],
    d2: %i[d1 d3 t1],
    d3: %i[d1 d2 t1],
    d4: %i[d5 d6 t4],
    d5: %i[d4 d6 t4],
    d6: %i[d4 d5 t4],
    s1: %i[t1 t2 t4],
    s2: %i[t3],
    t1: %i[d1 d2 d3 t2 t3],
    t2: %i[s1 t1 t3 t4],
    t3: %i[s2 t1 t2 t4],
    t4: %i[d4 d5 d6 t2 t3]
  }.freeze

  describe Board do
    before do
      @player1 = MockPlayer.new
      @player2 = MockPlayer.new
      @board = Board.new([@player1, @player2])
      @areas = @board.areas
    end

    describe "for two players" do
      it "has 13 areas" do
        _(@areas.size).must_equal 13
      end

      it "set 6 districts" do
        districts = @areas.select { |a| a.is_a?(Areas::District) }
        _(districts.size).must_equal 6
      end

      it "set player 1 to one city" do
        refute_nil @player1.city
      end

      it "set player 2 to one city" do
        refute_nil @player2.city
      end

      it "set different areas for each district" do
        common_areas = @player1.city.districts & @player2.city.districts
        assert_empty common_areas
      end

      it "set 4 deserts" do
        districts = @areas.select { |a| a.is_a?(Areas::Desert) }
        _(districts.size).must_equal 4
      end

      it "set 3 sanctuaries" do
        districts = @areas.select { |a| a.is_a?(Areas::Sanctuary) }
        _(districts.size).must_equal 3
      end

      EXPECTED_CONNECTIONS.each do |district_id, connections|
        it "connect #{district_id} correctly" do
          district  = @areas.find { |a| a.id == district_id }
          _(district.connections.map(&:id).sort).must_equal connections.sort
        end
      end
    end
  end
end
