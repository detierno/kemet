# frozen_string_literal: true

require "test_helper"

module Kemet
  class AreaTest < Minitest::Test
    def setup
      @area = Kemet::Area.new(:id)
    end

    def test_walled?
      refute @area.walled?
    end
  end
end
