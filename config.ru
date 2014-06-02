lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack'
require 'application.rb'

# 起動(port=9292)
run Sinatra::Application