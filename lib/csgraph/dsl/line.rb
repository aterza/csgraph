module Csgraph

	module DSL

		class Line
    
			attr_reader :xstart, :xend, :ystart, :yend, :options

			def initialize(ys, ye, opts = {})
				@ystart = ys
				@yend = ye
				@options = opts
			end

		end

	end

end
