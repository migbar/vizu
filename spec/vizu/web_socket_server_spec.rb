require File.dirname(__FILE__) + '/../spec_helper'

describe WebSocketServer do
  
  it "should handle filter message" do
    EM.run do
      filter_message =  { "filters" => ["foo" => "1", "bar" => "2"] }.to_json
      received = []

      EventMachine.add_timer(0.1) do
        http = EventMachine::HttpRequest.new('ws://127.0.0.1:8080/').get :timeout => 0
        http.errback { failed }
        http.stream {|msg|}
        http.callback {
          http.response_header.status.should == 101
          http.send filter_message
        }
      end

      WebSocketServer.start
    end                    
    
  end
  
end
