module Csgraph

  module DSL

    #
    # +PField+
    #
    class PField

      attr_reader :number, :coming_from_coerce

      def initialize(n)
        @coming_from_coerce = false
        @number = n
      end

      #
      # <tt>value(score_line)</tt>
      #
      # +value+ gets a score line and extracts the proper value according to
      # the +p-field+ number it represents
      #
      def value(sl)
        sl.params[self.number-1] # csound parameters are 1-offset but we save them as 0-offset
      end

      class << self

        def create(arg)
          num = arg.to_s.sub(/\A[Pp]/, '').to_i
          new(num)
        end

      end

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
        raise Exceptions::SyntaxError, "wrong operator type #{other.class.name}" unless other.is_a?(self.class) || other.is_a?(Numeric)
        self.coming_from_coerce ? PFieldExpression.new(other, self, op) : PFieldExpression.new(self, other, op)
      end

    end

  end

end
