module Kemet
  module Areas
    class Desert < Area
      def initialize(id, obelysk: false)
        @id = id
        @obelysk = obelysk
      end

      def obelysk?
        @obelysk
      end

    end
  end
end
