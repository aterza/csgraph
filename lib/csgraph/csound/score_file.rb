module Csgraph

  module Csound

    #
    # +ScoreFile+
    #
    # is the reader of the +csound+ score.
    #
    class ScoreFile

      attr_reader   :filename, :lines

      def initialize(fn)
        @filename = fn
				@lines = []
        parse
      end

		private

			def parse
				File.open(self.filename, 'r') do
					|fh|
					while(!fh.eof?)
						l = fh.gets.chomp
						sl = ScoreLine.compile(l)
						self.lines << sl if sl
					end
				end
				self.lines.sort! { |a,b| a.at <=> b.at }
			end

    end

  end

end
