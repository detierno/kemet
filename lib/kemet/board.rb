# frozen_string_literal: true
require 'psych'
# Psych.load(File.open(File.expand_path('lib/kemet/templates/boards/two_players.yml')))

module Kemet
  # Generate board instances for a match
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
        setup_districts
        setup_deserts
        setup_sanctuaries
        areas.flatten!

        link_board
      end

      def link_board
        link_deserts
        link_districts
        link_sanctuaries
      end

      def link_areas(id, *link_ids)
        area = areas.find { |area| area.id == id }
        targets = areas.select { |area| link_ids.include?(area.id) }
        area.link_areas(targets)
      end

      def link_deserts
        link_areas(:t2, :s1, :t1, :t4)
      end

      def link_districts
        link_areas(:d1, :d2, :d3, :t1)
        link_areas(:d2, :d1, :d3, :t1)
        link_areas(:d3, :d1, :d2, :t1)

        link_areas(:d4, :d5, :d6, :t4)
        link_areas(:d5, :d4, :d6, :t4)
        link_areas(:d6, :d4, :d5, :t4)
      end

      def link_sanctuaries
        link_areas(:s1, :t1, :t2, :t4)
        link_areas(:s2, :t3)
      end

      def setup_sanctuaries
        sanctuary1 = Areas::Sanctuary.new(:s1, prayer_points: 2)
        sanctuary2 = Areas::Sanctuary.new(:s2, prayer_points: 3)
        sanctuary3 = Areas::Sanctuary.new(:s3, prayer_points: 5)

        areas << [sanctuary1, sanctuary2, sanctuary3]
      end

      def setup_deserts
        desert1 = Areas::Desert.new(:t1)
        desert2 = Areas::Desert.new(:t2, obelysk: true)
        desert3 = Areas::Desert.new(:t3)
        desert4 = Areas::Desert.new(:t4)

        areas << [desert1, desert2, desert3, desert4]
      end

      def setup_districts
        district1 = Areas::District.new(:d1)
        district2 = Areas::District.new(:d2)
        district3 = Areas::District.new(:d3)
        district4 = Areas::District.new(:d4)
        district5 = Areas::District.new(:d5)
        district6 = Areas::District.new(:d6)

        areas << [district1, district2, district3, district4, district5, district6]
      end
  end
end
