module Csgraph

  #
  # +Renderer+
  #
  # this class is responsible for the csound score reading
  # It is expected to work well with any csound file, whether
  # it'd be a '.sco', a '.csd' or an '.orc' file (for which it
  # should do nothing of course) and a +.csg+ file (the CsGraph
  # description language)
  #
  class Renderer

    attr_reader :score_lines, :score_filename, :csg_filename, :output_stream

    def initialize(sfn, csg, os = STDOUT)
      @score_lines = []
      @score_filename = sfn
      @csg_filename = csg
			@output_stream = os
    end

    def render
      clear unless self.score_lines.empty?
      read
      #
      # TODO: the actual rendering!
      #
			self.output_stream
    end

  private

    include Csgraph::DSL::Reader

    def read
      read_csg_file
      read_score_file
			#
			# return the number of lines read and parsed
			#
			self.score_lines.size
    end

    def clear
      self.score_lines.clear
    end

    def read_score_file
      File.open(self.score_filename, 'r') do
        |fh|
        while(!fh.eof?)
          line = fh.gets
          sl = Csgraph::Csound::ScoreLine.compile(line)
          self.score_lines << sl if sl
        end
      end
    end

    def read_csg_file
      csg_require self.csg_filename
    end

  end

end
