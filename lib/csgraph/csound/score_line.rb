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

      def initialize(p = [])
        @params = p
      end

      #
      # +render+
      #
      # renders this score line in lines of +pic+ code.
      #
      # TODO: set up example code, with or without block
      #
      def render
        res = ''
        if block_given?
          res = yield(self.params)
        else
          res = default_render
        end
        res
      end

    protected

      #
      # <tt>default_render</tt>
      #
      # is a protected method which is implemented in subclasses. It
      # promotes a default action when a block is not passed to the +render+
      # method
      #
      def default_render
        ''
      end

    end

    class IScoreLine < ScoreLine; end

    class FScoreLine < ScoreLine; end

    class ScoreLine

      class << self

        #
        # <tt>compile(line)</tt>
        #
        # will compile any line coming from a csound score
        #
        def compile(line)
          res = nil
          return res unless line =~ /^\s*[fi]\s*[0-9]*/
          pars = line.chomp.sub(/\s*;.*$/, '').strip.split(/\s+/)
          line_type = pars[0][0]
          if pars[0][1..-1].empty?
            pars.shift
          else
            pars[0] = pars[0][1..-1]
          end
          klass = Object.const_get('Csgraph::Csound::' + line_type.upcase + 'ScoreLine')
          klass.send(:new, pars)
        end

      end

    end

  end
end
