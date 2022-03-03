# frozen_string_literal: true

module Kemet
  module Areas
    class District < Area # :nodoc:
      def allow_piramid?
        true
      end

      def walled?
        true
      end
    end
  end
end
