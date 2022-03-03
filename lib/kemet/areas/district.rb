module Kemet
  module Areas
    class District < Area
      def allow_piramid?
        true
      end

      def walled?
        true
      end
    end
  end
end
