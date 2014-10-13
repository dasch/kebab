ENV["RAILS_ENV"] = "test"

require 'dummy/config/environment'
require 'rspec/rails'

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))

