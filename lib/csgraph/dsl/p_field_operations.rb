module Csgraph

  module DSL

    module PFieldOperations

      def +(other)
        arithmetic(other, :__plus__)
      end

      def -(other)
        arithmetic(other, :__minus__)
      end

      def *(other)
        arithmetic(other, :__mul__)
      end

      def /(other)
        arithmetic(other, :__div__)
      end

      def **(other)
        arithmetic(other, :__pow__)
      end

      alias_method :^, :**

      def %(other)
        arithmetic(other, :__mod__)
      end

      #
      # +coerce(other)+
      #
      # this method is needed to perform the
      # addition with Numeric and the like
      #
      def coerce(other)
        @coerced = !other.is_a?(PFieldBase)
        [self, other]
      end

    private

      def arithmetic(other, op)
        raise Exceptions::SyntaxError, "wrong operator type #{other.class.name}" unless other.is_a?(PField) || other.is_a?(PFieldExpression) || other.is_a?(Numeric)
        res = self.coerced? ? PFieldExpression.new(other, self, op) : PFieldExpression.new(self, other, op)
        @coerced = false # this must be reset if we are in chained operations
        res
      end

    end

  end

end
