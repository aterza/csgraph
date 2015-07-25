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
		#   iline = ScoreLine.compile('i1 0.25 3.9875 -18.2 408.23 ; this is a comment')
		#   # => IScoreLine
		# </tt>
		#
    class ScoreLine

			private_class_method :new

			attr_accessor :params

			def initialize(p = [])
				@params = p
			end

		end

		class IScoreLine < ScoreLine; end

		class FScoreLine < ScoreLine; end

		class ScoreLine

			class << self

				def compile(line)
					res = nil
					return res unless line =~ /^\s*[fi]\s*[0-9]*/
					pars = line.chomp.strip.split(/\s+/)
					line_type = pars[0][0]
					if pars[0][1..-1].empty?
						pars.shift
					else
						pars[0] = pars[0][1..-1]
					end
					klass = (line_type.upcase + 'ScoreLine').constantize
					klass.new(pars)
				end

			end

    end

  end
end
