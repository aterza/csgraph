module Csgraph

  module DSL

    #
    # +Definitions+
    #
    # +Definitions+ is the container class that holds
		# all the instructions to build a graph out of a csound score.
		# It is a collection of definitions, one for each [group of]
		# instrument[s].
		#
		# Technically, it is a singleton class. It cannot be created, and there is
		# only +one+ instance called +CsGraph available. This allows constructs
		# like
		#
    # An example of a very basic definition is
    #
    #    CsGraph.define do
    #  
    #      instr 1,2,3 do
    #
    #       line p2, p2+p3, p5, p5, :thickness => 4 (method missing)
    #
    #      end
    #
    #    end
    #
    # which means "for instr 1,2,3 draw lines taking pfield 5 as y start point, pfield 5
    # as y end point, and adjusting the thickness of the line to pfield
    # 4"
    #
    #
    class Definitions < Hash

			private_class_method :new

      def define(&block)
      end
      
      def instr(*args, &block)
        i = Instr.new(*args, &block)
        i.instruments.each { |ins| self.update(ins.to_s => i) } 
      end
        
    end
    

  end

end

#
# +CsGraph+ is the singleton container
#
CsGraph = Csgraph::DSL::Definitions.send(:new)
