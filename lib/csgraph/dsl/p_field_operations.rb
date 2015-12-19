module Csgraph

  module DSL

    module PFieldOperations

      attr_reader :coming_from_coerce

      def +(other)
        arithmetic(other, :__plus__)
      end

      def -(other)
        arithmetic(other, :__minus__)
      end

      #
      # +coerce(other)+
      #
      # this method is needed to perform the
      # addition with Numeric and the like
      #
      def coerce(other)
        @coming_from_coerce = true
        [self, other]
      end

    private

      def arithmetic(other, op)
        raise Exceptions::SyntaxError, "wrong operator type #{other.class.name}" unless other.is_a?(PField) || other.is_a?(PFieldExpression) || other.is_a?(Numeric)
        self.coming_from_coerce ? PFieldExpression.new(other, self, op) : PFieldExpression.new(self, other, op)
      end

    end

  end

end
