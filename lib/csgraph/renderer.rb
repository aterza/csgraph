module Csgraph

  #
  # +Renderer+
  #
  # this class is responsible for the csound score reading
  # It is expected to work well with any csound file, whether
  # it'd be a '.sco', a '.csd' or an '.orc' file (for which it
  # should do nothing of course) and a +.csg+ file (the Csgraph
  # description language)
  #
  class Renderer

    attr_reader :score_lines, :csg_filename, :output_stream, :definitions

    def initialize(csg, os = STDOUT)
      @score_lines = []
			self.definitions = csg
      @output_stream = os
    end

    def render(score_filename)
      clear unless self.score_lines.empty?
      read(score_filename)
			self.score_lines.each do
				|sl|
				sl.render(self.definitions, self.output_stream)
			end
      self.output_stream
    end

		def definitions=(csg_file)
      clear unless self.score_lines.empty?
      @csg_filename = csg_file
			@definitions = read_csg_file
		end

  private

    include Csgraph::DSL::Reader

    def read(sfn)
      read_score_file(sfn)
      #
      # return the number of lines read and parsed
      #
      self.score_lines.size
    end

    def clear
      self.score_lines.clear
    end

    def read_score_file(sfn)
      File.open(sfn, 'r') do
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
