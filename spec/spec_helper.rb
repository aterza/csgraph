if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
	require 'simplecov'
  SimpleCov.start
end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'csgraph'
require 'tmpdir'
require 'byebug'

SPEC_FIXTURE_PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
SPEC_CSG_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'csg')
SPEC_CSOUND_FIXTURE_PATH = File.join(SPEC_FIXTURE_PATH, 'csound')
