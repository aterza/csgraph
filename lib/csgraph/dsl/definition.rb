module Csgraph

  module DSL

    #
    # +Definition+
    #
    # Technically, +Definition+, is the container class that holds the full
    # definition of a graph to build. That includes:
    #
    # * the way lines are created
    # * the way curves are created
    # * system environment (paper format, etc.)
    #
    class Definition

			private_class_method :new

      def define
      end

    end

  end

end

#
# +CsGraph+ is the singleton container definition
#
CsGraph = Csgraph::DSL::Definition.send(:new)
