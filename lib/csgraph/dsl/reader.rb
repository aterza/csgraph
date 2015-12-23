module Csgraph

  module DSL

    module Reader

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
        csg_def = nil
        begin
          csg_def = Csgraph::DSL::Definitions.new
          csg_def.csg_require(filename)
        rescue SyntaxError => e
          raise Csgraph::DSL::Exceptions::SyntaxError, "Csgraph DSL Syntax Error: " + e.message
        end
        csg_def
      end

    end

  end

end
