# frozen_string_literal: true

module Kemet
  module Areas
    class District < Area # :nodoc:
      attr_accessor :owner

      def allow_piramid?
        true
      end

      def walled?
        true
      end
    end
  end
end
