class WebSocketServer       
  FILTERS_KEY = "filters"

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
      ws.onopen do
        puts "WebSocket connection opened"
        @sids = {} 
        @channels = parse_channels(ws.request['Path'])
      end

      ws.onmessage do |msg|
        if message_is_filters(msg)          
          @filters = create_filters(msg)
          @channels.each do |channel|
            sid = channel.subscribe { |line| broadcast(ws, line) }
            puts "subscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
            @sids[channel] = sid 
          end
        end
      end

      ws.onclose do
        puts "VIZU server received a Connection closed from #{@sids.inspect}" 
        @sids.each do |channel, sid|
          puts "\tunsubscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
          channel.unsubscribe sid
        end
      end
            
    end
  end 
  
  def self.broadcast(ws, line)
    if (log_event = parse(line))  
      ws.send(log_event.to_json) if relevant? log_event
    end
  end                               
  
  def self.relevant?(log_event)
    @filters.detect { |f| f.matches? log_event }
  end
  
  def self.message_is_filters(msg)
    !!filters(msg)
  end
  
  def self.parse_channels(path)
    [ Channels::Accessibility ]
  end
  
  def self.parse(line)
    HummingParser.parse line
  end    
  
  def self.create_filters(msg)  
    filters(msg).collect { |e| Filter.new e.to_hash.symbolize_keys }
  end   
  
  def self.filters(msg)
    JSON.parse(msg)[FILTERS_KEY] 
  end
                         
end