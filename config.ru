require 'rubygems'
require 'bundler'
require 'active_record'

Bundler.require

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '.'))

api_dir = File.dirname(__FILE__) + '/app/apis/*.rb'
model_dir = File.dirname(__FILE__) + '/app/models/*.rb'
config_dir = File.dirname(__FILE__) + '/config/initializers/*.rb'
lib_dir = File.dirname(__FILE__) + '/lib/*.rb'
Dir[api_dir, model_dir, config_dir, lib_dir].each { |file| require file }

run Rack::URLMap.new({
  "/s" => SessionsApi,
  "/u" => UsersApi,
  "/tests" => TestsApi
})