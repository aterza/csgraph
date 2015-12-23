module Csgraph

  module DSL

    #
    # +PFieldBase+
    #
    # is the base class for both +PField+ and +PFieldExpression+
    #
    class PFieldBase

      attr_reader :converters

      def initialize
        @coerced = false
        @converters = []
      end

      def coerced?
        @coerced
      end

      #
      # <tt>add_converter(c)</tt>
      #
      # adds a converter to the chain of converters for this particular field
      #
      def add_converter(c)
        @converters << c
      end

      #
      # <tt>clear_converters</tt>
      #
      # clear the chain of converters
      #
      def clear_converters
        @converters = []
      end

      #
      # <tt>convert(val)</tt>
      #
      # The value is passed through the chain
      # of converters (if any) and returns the appropriate converted result.
      #
      def convert(val)
        res = val
        self.converters.each do
          |conv|
          extend Csgraph::Csound::Conversions::Actual
          res = self.send(conv, res)
        end
        res
      end

      include PFieldOperations

    end

  end

end
