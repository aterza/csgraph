module Csgraph

  module DSL

    #
    # <tt>Options</tt>
    #
    # <tt>Options</tt> is the class for handling options in all +DSL+ commands
    # It is a subclass of +Hash+ and it is the superclass of the different
    # option classes for the different commands.
    #
    class Options < Hash
    
      attr_reader :allowed_keys, :keyword

      def initialize(orig_hash, kw, ak = [])
        self.update(orig_hash.stringify_keys)
        @keyword = kw
        @allowed_keys = ak
        check_for_validity
      end

      def render(score_line)
        raise Csgraph::Exceptions::PureVirtualMethod, "#{self.class.name}#render is a pure virtual method"
      end

    private

      def check_for_validity
        wrong_options = []
        self.keys.each { |k| wrong_options << k unless self.allowed_keys.include?(k) }
        raise ArgumentError, "unknown option(s) #{wrong_options.join(', ')} for keyword #{self.keyword}" unless wrong_options.empty?
      end

    end

  end

end

