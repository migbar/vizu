class WebSocketServer

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
      ws.onopen do
        puts "WebSocket connection opened"
        @sids = {}
        @channels = get_channels(ws.request['Path'])
        @channels.each do |channel|
           sid = channel.subscribe do |line| 
            if (processed = process(line))
              # puts "pushing #{processed}"
              ws.send(processed)
            end
          end
          puts "subscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
          @sids[channel] = sid 
        end
      end

      ws.onclose do
        puts "VIZU server received a Connection closed from #{@sids.inspect}" 
        @sids.each do |channel, sid|
          puts "unsubscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
          channel.unsubscribe sid
        end
        # Channels::Accessibility.unsubscribe @sid
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
  
  def self.get_channels(path)
    [Channels::Accessibility]
  end
  
end