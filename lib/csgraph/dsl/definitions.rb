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
    # only +one+ instance called +CsGraph+ available. This allows constructs
    # like
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
    # which means "for instr 1,2,3 draw lines taking pfield 5 as y start point, pfield 5
    # as y end point, and adjusting the thickness of the line to pfield 4"
    #
    # These definitions can all be loaded into a +.csg+ file which can then be
    # passed to the +csgraph+ executable.
    #
    # +Instr+s requires a variable number of arguments which are all pfield
    # variables. We use the +method_missing+ method in order to construct
    # variables as they appear as arguments.
    #
    class Definitions < Hash

      private_class_method :new

      def define(&block)
        #
        # this is an empty function which encloses all instrument definitions
        #
      end
      
      #
      # <tt>instr(*args, &block)</tt>
      #
      # the +instr+ method accept a variable number of arguments which are all
      # instrument numbers. Each number generates a definition which carries
      # out the number of operations required for that instrument.
      #
      def instr(*args, &block)
        args.each do
          |n|
          i = Instr.new(n, &block)
          self.update(i.number.to_s => i)
        end
      end

      #
      # <tt>method_missing(method)</tt>
      #
      def method_missing(methId)
        str = methId.id2name
byebug
nop = 0
      end
        
    end
    

  end

end

#
# +CsGraph+ is the singleton container
#
CsGraph = Csgraph::DSL::Definitions.send(:new)
