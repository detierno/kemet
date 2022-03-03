# frozen_string_literal: true

module Kemet
  class Board
    def initialize(players)
      @players = players
      setup
    end

    def areas
      @areas ||= []
    end

    private

    def setup
      district1 = Areas::District.new(:d1)
      district2 = Areas::District.new(:d2)
      district3 = Areas::District.new(:d3)

      desert1 = Areas::Desert.new(:t1)
      desert2 = Areas::Desert.new(:t2, obelysk: true)
      desert3 = Areas::Desert.new(:t3)
      desert4 = Areas::Desert.new(:t4)

      sanctuary1 = Areas::Sanctuary.new(:s1, prayer_points: 2)
      sanctuary2 = Areas::Sanctuary.new(:s2, prayer_points: 3)
      sanctuary3 = Areas::Sanctuary.new(:s3, prayer_points: 5)

      district4 = Areas::District.new(:d4)
      district5 = Areas::District.new(:d5)
      district6 = Areas::District.new(:d6)

      district1.link_areas(district2, district3, desert1)
      district2.link_areas(district1, district3, desert1)
      district3.link_areas(district1, district2, desert1)


      areas << [district1, district2, district3, district4, district5, district6]
      areas << [desert1, desert2, desert3, desert4]
      areas << [sanctuary1, sanctuary2, sanctuary3]
      areas.flatten!
    end
  end
end
