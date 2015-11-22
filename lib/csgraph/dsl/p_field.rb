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

			class << self

				def create(arg)
					num = arg.to_s.sub(/\A[Pp]/, '').to_i
					new(num)
				end

			end

    end

  end

end
