$:.unshift File.expand_path(File.join(*%w(.. app)), __FILE__)

require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV['RACK_ENV'] || :development)

ActiveSupport::JSON::Encoding.use_standard_json_time_format = true
ActiveSupport.parse_json_times = true

require "services/comment_service"