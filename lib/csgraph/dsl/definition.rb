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
    #    CsGraph.define 1,2,3 do
    #  
    #      line 5, 5, :thickness => 4
    #
    #    end
    #
    # which means "draw lines taking pfield 5 as y start point, pfield 5
    # as y end point, and adjusting the thickness of the line to pfield
    # 4"
    #
    #
    class Definition

      attr_accessor :instrs, :features

			def initialize(*args, &block)
				@instr = args
				@features = block.call
			end

			def line(ystart, yend, options = {})
				Line.new(ystart, yend, options)
			end

    end

  end

end
