module Csgraph

	module DSL

		module Exceptions

			class SyntaxError < ::SyntaxError

				def initialize(bt)
					@message = bt
				end

			end

		end

	end

end
