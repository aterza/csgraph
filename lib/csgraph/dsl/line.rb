module Csgraph

  module DSL

    class Line
    
      attr_reader :xstart, :xend, :ystart, :yend, :options

      def initialize(xs, xe, ys, ye, opts = {})
        @xstart = xs
        @xend = xe
        @ystart = ys
        @yend = ye
        @options = opts
      end

      #
      # <tt>render(score_line, output_stream)</tt>
      #
      # this is actually one of the possible final +render+s of csgraph:
      # values are extracted from pfields or expressions and substituted in
      # the actual output line
      #
      def render(sl, os)
        xstart_val = self.xstart.value(sl)
        xend_val = self.xend.value(sl)
        ystart_val = self.ystart.value(sl)
        yend_val = self.yend.value(sl)
        #
        # TODO: handle options
        #
        # and finally we render
        #
        os.puts("line from #{xstart_val},#{ystart_val} to #{xend_val},#{yend_val}")
        os
      end

    end

  end

end
