module Csgraph

  module DSL

    #
    # +PFieldBase+
    #
    # is the base class for both +PField+ and +PFieldExpression+
    #
    class PFieldBase

      def initialize
        @coerced = false
      end

      def coerced?
        @coerced
      end

      include PFieldOperations

    end

  end

end
