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

		end

	end

end
