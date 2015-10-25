module Csgraph

  module DSL

    #
    # +Definitions+
    #
    # +Definitions+ is the container class that holds
		# all the instructions to build a graph out of a csound score.
		# It is a collection of definitions, one for each [group of]
		# instrument[s].
		#
		# Technically, it is a singleton class. It cannot be created, and there is
		# only +one+ instance called +CsGraph available. This allows constructs
		# like
		#
    #
    class Definitions < Array

			private_class_method :new

      def define(*args, &block)
				self << Definition.new(*args, &block)
      end

    end

  end

end

#
# +CsGraph+ is the singleton container
#
CsGraph = Csgraph::DSL::Definitions.send(:new)
