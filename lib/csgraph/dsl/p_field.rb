module Csgraph

  module DSL

    #
    # +PField+
    #
    class PField

      attr_reader :number

      def initialize(n)
        @number = n
      end

			#
			# TODO
			# +eval+
			#

      class << self

        def create(arg)
          num = arg.to_s.sub(/\A[Pp]/, '').to_i
          new(num)
        end

      end

      def +(other_pfield)
        raise Exceptions::SyntaxError, "wrong operator type #{other_pfield.class.name}" unless other_pfield.is_a?(self.class)
				PFieldExpression.new(self, other_pfield, :+)
      end

    end

  end

end
