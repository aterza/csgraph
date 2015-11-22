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
    #       line p2, p2+p3, p5, p5, :thickness => 4
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
        block.call
      end

      def line(xstart, xend, ystart, yend, options = {})
        @features << Line.new(xstart, xend, ystart, yend, options)
      end

    end

  end

end
