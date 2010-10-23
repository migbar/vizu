class Vizu
  
  def self.start
    EM.run do
      # Listener.start_all        # Listen to all the NetStar servers
      run
    end
  end
  
  def self.run
    LogReceiver.start           # start receiving logs
    Broadcaster.start_all       # setup all the broadcasting channels
    WebSocketServer.start       # listen for websockets
    # Clients.come_in             # (simulation-only) vizu clients come in
  end
end

