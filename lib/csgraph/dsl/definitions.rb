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
    # An example of a very basic definition is
    #
    #   instr 1,2,3 do
    #
    #     line p2, p2+p3, p5, p5, :thickness => p4
    #
    #   end
    #
    # which means "for instr 1,2,3 draw lines taking pfield 5 as y start point, pfield 5
    # as y end point, and adjusting the thickness of the line to pfield 4"
    #
    # There can be as many +instr+ definitions and as many inner definitions
    # as you wish.
    #
    # These definitions can all be loaded into a +.csg+ file which can then be
    # passed to the +csgraph+ executable.
    #
    # +line+s requires a variable number of arguments which are all pfield
    # variables. We use the +method_missing+ method in order to construct
    # variables as they appear as arguments.
    #
    class Definitions < Hash

      def csg_require(filename_path)
        clear
				csg_string = read(filename_path)
				self.instance_eval(csg_string)
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
          self.update(i.instrno.to_s => i)
        end
      end

      #
      # <tt>render(score_line, output_stream)</tt>
      #
      # This is where the whole sha-bang takes place.
      # +render+ will pick up a given +ScoreLine+ object,
      # identify the relevant +instr+ info coming from the +.csg+
      # configuration and actually pass the line to that object
      #
      def render(sl, os)
        #
        # we do render only +i+-score lines at the moment
        #
        if sl.is_a?(Csgraph::Csound::IScoreLine)
          i = self[sl.instr.to_s]
          i.render(sl, os) if i
        end
      end

    private

      def read(f)
        res = ''
        File.open(f, 'r') do
          |fh|
          res = fh.readlines.join
        end
        res
      end

    end
    

  end

end
