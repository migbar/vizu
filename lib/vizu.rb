$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'eventmachine'
require 'em-websocket'
require 'json'

require 'time'

require 'vizu/broadcaster'
require 'vizu/gource_processor'
require 'vizu/humming_processor'
require 'vizu/log_receiver'
require 'vizu/broadcasters/accessibility'
require 'vizu/broadcasters/portal'
require 'vizu/broadcasters/transaction'
require 'vizu/channels'
require 'vizu/clients'
require 'vizu/listener'
require 'vizu/web_socket_server'
require 'vizu/vizu'

Vizu.start