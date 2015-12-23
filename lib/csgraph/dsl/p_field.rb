module Csgraph

  module DSL

    #
    # +PField+
    #
    class PField < PFieldBase

      attr_reader :number

      def initialize(n)
        super()
        @number = n
      end

      #
      # <tt>value(score_line)</tt>
      #
      # +value+ gets a score line and extracts the proper value according to
      # the +p-field+ number it represents.
      #
      def value(sl)
        res = sl.params[self.number-1] # csound parameters are 1-offset but we save them as 0-offset
        self.convert(res)
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
