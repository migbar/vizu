$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'vizu'
require 'rspec'
require 'rspec/autorun'

require 'eventmachine'
require 'em-websocket'
require 'em-http-request'


RSpec.configure do |config|
  
end
