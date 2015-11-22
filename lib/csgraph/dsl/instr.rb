module Csgraph

  module DSL

    #
    # +Definition+
    #
    # Technically, +Definition+, is the class that holds the full
    # definition of a graph to build for a given instrument (or group of
    # instruments)
    #
    # An example of a very basic definition is
    #
    #    CsGraph.define do
    #  
    #      instr 1,2,3 do
    #
    #       line p2, p2+p3, p5, p5, :thickness => p4
    #
    #      end
    #
    #    end
    #
    # which means "draw lines taking pfield 5 as y start point, pfield 5
    # as y end point, and adjusting the thickness of the line to pfield
    # 4"
    #
    #
    class Instr

      attr_reader :instrno, :features

      def initialize(n, &block)
        @instrno = n
        @features = []
        instance_eval(&block)
      end

      def line(xstart, xend, ystart, yend, options = {})
        @features << Line.new(xstart, xend, ystart, yend, options)
      end

      #
      # <tt>method_missing(methId)</tt>
      #
      def method_missing(methId)
        str = methId.id2name
        raise ArgumentError, "Argument can only be a mumeric constant or a p-field (got \"#{str}\" instead)" unless str != /\A[Pp]\s*[0-9]*/
        num = str.sub(/\A[Pp]/, '').to_i
        PField.new(num)
      end
        
    end

  end

end
