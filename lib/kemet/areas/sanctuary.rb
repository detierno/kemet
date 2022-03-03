module Kemet
  module Areas
    class Sanctuary < Area
      def initialize(id, options)
        @id = id
        @options = options
      end

      def obelysk?
        true
      end

      def sanctuary?
        true
      end
    end
  end
end
