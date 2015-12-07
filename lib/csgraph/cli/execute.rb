#
#
#
require 'optparse'

module Csgraph

  module CLI

    class << self

      include Csgraph::DSL::Reader

      #
      # <tt>execute(arguments=[])
      #
      # +execute+ does actually parse options and produces the output
      #
      def execute(arguments=[])
  
        options = {
          :csg              => Csgraph::DSL::DEFAULT_CSG_FILE,
          :output           => STDOUT
        }

        parser = OptionParser.new do |opts|
          opts.banner = <<-BANNER.gsub(/^          /,'')
            
            csgraph is a small ruby library and executable to create pic scripts from csound scores suitable to be printed as graphics
  
            Usage: #{File.basename($0)} [options]
  
            Options are:
          BANNER
          opts.separator ""
          opts.on("-f", "--csgraph FILE", String,
                  "use csgraph file found in  PATH",
                  "Default: #{Csgraph::DSL::DEFAULT_CSG_FILE}") { |arg| options[:csg] = arg }
          opts.on("-o", "--output FILE", String,
                  "write to output file FILE",
                  "Default: STDOUT") { |arg| options[:output] = File.open(arg, 'w') }
          opts.on("-h", "--help",
                  "Show this help message.") { options[:output].puts opts; exit }
          opts.parse!(arguments)
        end
  
        defs = csg_require(options[:csg])
        arguments.each do
          |csd|
          sf = Csgraph::Csound::ScoreFile.new(csd)
          sf.lines.each { |sl| defs.render(sl, options[:output]) }
        end

        #
        # return the open output stream
        #
        options[:output] 
  
      end

    end

  end

end
