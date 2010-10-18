class WebSocketServer

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
        ws.onopen do
          puts "WebSocket connection open"
          # publish message to the client
          ws.send "VIZU server says: Hello Client"
          @sid = Channels::Accessibility.subscribe{|m| ws.send m}
        end

        ws.onclose do
          puts "VIZU server received a Connection closed from #{@sid}" 
          Channels::Accessibility.unsubscribe @sid
        end
        ws.onmessage { |msg|
          puts "Received message: #{msg}"
          ws.send "Pong: #{msg}"
        }
    end
  end
  
end