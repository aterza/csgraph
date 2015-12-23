module Csgraph
  module Csound
    PATH = File.expand_path(File.join('..', 'csound'), __FILE__)
    DEFAULT_SCORE_FILE = File.join(PATH, ['..'] * 3, 'share', 'sco', 'simple.sco')
  end
end

%w(
  score_line
  score_file
  conversions
).each { |f| require File.join(Csgraph::Csound::PATH, f) }
