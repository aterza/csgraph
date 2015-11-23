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
      # <tt>value(score_line)</tt>
      #
      # +value+ gets a score line and extracts the proper value according to
      # the expression contained in the +p-field expression+
      #
      def value(sl)
        lval = extract_value(sl, self.left)
        rval = extract_value(sl, self.right)
        self.send(self.operator, lval, rval)
      end


    private

      def check_argument(operand)
        raise Exceptions::SyntaxError, "operand #{operand.class.name} is not a p-field" unless operand.is_a?(PField) || operand.is_a?(PFieldExpression) || operand.is_a?(Numeric)
        operand
      end

      def extract_value(sl, operand)
        res = nil
        if operand.is_a?(Numeric)
          res = operand
        elsif operand.is_a?(PField)
          res = sl.params[operand.number-1] # csound parameters are 1-offset but we save them as 0-offset
        else
          raise Exceptions::SyntaxError, "cannot handle operand #{operand.class.name}"
        end
        res
      end

      def __plus__(lval, rval)
        lval + rval
      end

      def __minus__(lval, rval)
        lval - rval
      end

    end

  end

end
