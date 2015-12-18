module Csgraph

  module DSL

    class Line

      attr_reader :xstart, :xend, :ystart, :yend, :options

      def initialize(xs, xe, ys, ye, opts = {})
        @xstart = xs
        @xend = xe
        @ystart = ys
        @yend = ye
        @options = Options.new(opts)
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
        # and finally we render
        #
        os.puts("line from Frame.sw+(#{xstart_val}*hrange,#{ystart_val}*vrange) to Frame.sw+(#{xend_val}*hrange,#{yend_val}*vrange) #{self.options.render(sl)}")
        os
      end

    private

      class Options < Csgraph::DSL::Options

         ALLOWED_OPTIONS = ['thickness']

         def initialize(opts)
           super(opts, 'line', ALLOWED_OPTIONS)
         end

         def render(sl)
           res = []
           res << "thickness #{self['thickness'].value(sl).to_s}" if self.has_key?('thickness')
           res.join(' ') 
         end

      end
      
    end

  end

end
