# frozen_string_literal: true

require "test_helper"

class KemetTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Kemet::VERSION
  end

  def test_a_full_match
    match = Kemet::Match.new
    red_player = match.add_player(:red)
    green_player = match.add_player(:green)

    # match.setup!
  end
end
