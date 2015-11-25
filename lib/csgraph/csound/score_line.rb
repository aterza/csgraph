module Csgraph
  module Csound

    #
    # +ScoreLine+
    #
    # is the base class of all types of +ScoreLine+ objects
    #
    # The +new+ method has been disabled for this class. The +compile+ method
    # should be used instead. For ex.:
    #
    # <tt>
    #   iline = Csgraph::Csound::ScoreLine.compile('i1 0.25 3.9875 -18.2 408.23 ; this is a comment')
    #   # => Csgraph::CsoundIScoreLine
    # </tt>
    #
    class ScoreLine

      private_class_method :new

      attr_accessor :params
			attr_reader   :line

      def initialize(l, p = [])
        @params = p
				@line = l
      end

      #
      # +render(ostream)+
      #
      # This is a pure virtual method which should raise an exception when called
      #
      def render(ostream)
        raise Csgraph::Exceptions::PureVirtualMethod, "render() is a pure virtual method in class #{self.class.name}"
      end

    end

    class IScoreLine < ScoreLine

      def render(ostream)
        CsGraph.render(self, ostream)
        ostream
      end

      def instr
        self.params.first
      end

    end

    class FScoreLine < ScoreLine

      def render(ostream)
        #
        # currently f score lines do nothing while rendering
        #
        ostream
      end

    end

    class ScoreLine

      class << self

        #
        # <tt>compile(line)</tt>
        #
        # will compile any *score* line coming from a csound score
        #
        SCORE_LINE_REGEXP = /\A\s*[fi]\s*[0-9]/

        def compile(line)
          res = nil
          return res unless line =~ SCORE_LINE_REGEXP
          pars = line.chomp.sub(/\s*;.*\Z/, '').strip.split(/\s+/)
          line_type = pars[0][0]
          if pars[0][1..-1].empty?
            pars.shift
          else
            pars[0] = pars[0][1..-1]
          end
          pars = pars.map { |p| p = p.to_f }
          klass = Object.const_get('Csgraph::Csound::' + line_type.upcase + 'ScoreLine')
          klass.send(:new, line, pars)
        end

      end

    end

  end
end
