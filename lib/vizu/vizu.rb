class Vizu
  def self.start
    EM.run do
      # Listener.start_all           # Listen to all the NetStar servers
      LogReceiver.start
      Broadcaster.start_all        # setup all the broadcasting channels
      WebSocketServer.start
      Clients.come_in              # (simulation-only) vizu clients come in
    end
  end
end