module Csgraph

  module DSL

    module Reader

      class << self

        #
        # +csg_require(filename)+
        #
        # +csg_require+ loads a '.csg' tagged file, adding a +.csg+ suffix if
        # needed.
        #
        # TODO: we need to write some syntax error display and recovery
        #
        def csg_require(filename)
          filename += '.csg' unless filename =~ /\.csg\Z/
					begin
            load(filename)
					rescue SyntaxError => e
						raise Csgraph::DSL::Exceptions::SyntaxError, "CsGraph::DSL Syntax Error: " + e.message
					end
        end

      end

    end

  end

end
