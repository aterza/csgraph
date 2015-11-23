module Csgraph

  module DSL

    #
    # +PFieldExpression+
    #
    class PFieldExpression

      attr_reader :left, :right, :operator

      def initialize(l, r, o)
        @left = check_argument(l)
        @right = check_argument(r)
        @operator = o
      end

      #
      # TODO
      # +eval+
      #

    private

      def check_argument(operand)
        raise Exceptions::SyntaxError, "operand #{operand.class.name} is not a p-field" unless operand.is_a?(PField) || operand.is_a?(PFieldExpression) || operand.is_a?(Numeric)
        operand
      end

    end

  end

end

