require 'rubygems'
require 'eventmachine'
require 'em-websocket'

require 'vizu/broadcaster'
require 'vizu/log_receiver'
require 'vizu/broadcasters/accessibility'
require 'vizu/broadcasters/portal'
require 'vizu/broadcasters/transaction'
require 'vizu/channels'
require 'vizu/clients'
require 'vizu/listener'
require 'vizu/web_socket_server'

EM.run do
  # Listener.start_all           # Listen to all the NetStar servers
  
  LogReceiver.start
  Broadcaster.start_all        # setup all the broadcasting channels
  WebSocketServer.start
  Clients.come_in              # (simulation-only) vizu clients come in
                               # EM.add_timer(5) { EM.stop } stops EM 
end