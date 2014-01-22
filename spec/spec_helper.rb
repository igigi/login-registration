require 'sinatra'
require 'rack/test'
require 'active_record'
require File.expand_path '../../app/apis/base_api.rb', __FILE__
model_dir = File.expand_path '../../app/models/*.rb', __FILE__
helper_dir = File.expand_path '../../app/helpers/*.rb', __FILE__
Dir[model_dir, helper_dir].each { |file| require file }

module RSpecMixin include Rack::Test::Methods end
RSpec.configure { |c| c.include RSpecMixin }