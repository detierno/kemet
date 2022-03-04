# frozen_string_literal: true

require "test_helper"

describe Kemet do
  describe "a 2 player full match" do
    it "works" do
      match = Kemet::Match.new
      _red_player = match.add_player(:red)
      _green_player = match.add_player(:green)

      # match.setup!
    end
  end
end
