class WebSocketServer

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
        
        ws.onopen do
          puts "WebSocket connection opened"
          @sid = Channels::Accessibility.subscribe do |line| 
            if (processed = process(line))
              puts "pushing #{processed}"
              ws.send(processed)
            end
          end
        end

        ws.onclose do
          puts "VIZU server received a Connection closed from #{@sid}" 
          Channels::Accessibility.unsubscribe @sid
        end

        # no incoming message for now
        # ws.onmessage { |msg|
        #   puts "Received message: #{msg}"
        #   ws.send "Pong: #{msg}"
        # }
    end
  end
  
  def self.process(line)
    HummingProcessor.process line
  end
  
end