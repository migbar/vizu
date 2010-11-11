class WebSocketServer

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
      ws.onopen do
        puts "WebSocket connection opened"
        @sids = {} 
        @channels = parse_channels(ws.request['Path'])
      end

      ws.onmessage do |msg|
        if message_is_filter_payload(msg)          
          filters = parse_filters(msg)
          @channels.each do |channel|
             sid = channel.subscribe do |line| 
              if (processed = process(line))  
                match_found = filters.detect { |f| f.matches? processed }
                ws.send(processed.to_json) if match_found
              end
            end
            puts "subscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
            @sids[channel] = sid 
          end
        end
      end

      ws.onclose do
        puts "VIZU server received a Connection closed from #{@sids.inspect}" 
        @sids.each do |channel, sid|
          puts "unsubscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
          channel.unsubscribe sid
        end
      end
            
    end
  end
  
  def self.message_is_filter_payload(msg)
    !!JSON.parse(msg)["filters"]
  end
  
  def self.parse_channels(path)
    [Channels::Accessibility]
  end
  
  def self.process(line)
    HummingProcessor.process line
  end    
  
  def self.parse_filters(msg)  
    JSON.parse(msg)['filters'].collect do |e|  
      Filter.new e.to_hash.symbolize_keys 
    end
  end
                         
end