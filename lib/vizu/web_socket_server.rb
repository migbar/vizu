class WebSocketServer

  def self.start
    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
      ws.onopen do
        puts "WebSocket connection opened"
        @sids = {}
        # @channels = get_channels(ws.request['Path'])
        # # create a filter based on the incoming payload
        # # ask the client to send in their filters
        # @channels.each do |channel|
        #    sid = channel.subscribe do |line| 
        #     if (processed = process(line))
        #       ws.send(processed) # if filter matches line ...
        #     end
        #   end
        #   puts "subscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
        #   @sids[channel] = sid 
        # end
      end

      ws.onclose do
        puts "VIZU server received a Connection closed from #{@sids.inspect}" 
        @sids.each do |channel, sid|
          puts "unsubscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
          channel.unsubscribe sid
        end
      end
      
      ws.onmessage do |msg|
        # ... receive filters?
        puts "MESSAGE IS #{msg}"
        if message_is_filter_payload(msg)
          puts "it is filters!!!!!!!!"
          puts "incoming message #{JSON.parse(msg)['filters'].each {|e|puts e.to_hash}}"
          
          @sids = {}
          # channel, server = parse_path(ws.request['Path'])
          filter = Filter.new(:server => server, :details => payload)
          @channels = get_channels()
          # create a filter based on the incoming payload
          # ask the client to send in their filters
          @channels.each do |channel|
             sid = channel.subscribe do |line| 
              if (processed = process(line))
                ws.send(processed) if filter.matches?(line)
              end
            end
            puts "subscribing channel: #{channel.inspect}, sid: #{sid.inspect}"
            @sids[channel] = sid 
          end
        end
      end
    end
  end
  
  def self.message_is_filter_payload(msg)
    !!JSON.parse(msg)["filters"]
  end
  
  def self.parse_path(path)
    
  end
  
  def self.process(line)
    HummingProcessor.process line
  end
  
  def self.get_channels(path)
    [Channels::Accessibility]
  end
  
end