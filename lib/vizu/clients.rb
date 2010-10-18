class Clients

  def self.come_in
    # Two client connections looking for accessibility, that just print what they receive.
    2.times do
      puts "client connection looking for accessibility"
      EM.connect('0.0.0.0', 1250) do |c|
        c.extend EM::P::LineText2
        def c.receive_line(line)
          puts "Subscriber: #{signature} got #{line}"
        end
        # EM.add_timer(2) { c.close_connection }
      end
    end

    # Two client connections looking for portal, that just print what they receive.
    2.times do
      puts "client connection looking for portal"
      EM.connect('0.0.0.0', 1260) do |c|
        c.extend EM::P::LineText2
        def c.receive_line(line)          
          puts "Subscriber: #{signature} got #{line}"
        end
        # EM.add_timer(2) { c.close_connection }
      end
    end

    # Two client connections looking for transaction, that just print what they receive.
    2.times do
      puts "client connection looking for transaction"
      EM.connect('0.0.0.0', 1270) do |c|
        c.extend EM::P::LineText2
        def c.receive_line(line)
          puts "Subscriber: #{signature} got #{line}"
        end
        # EM.add_timer(2) { c.close_connection }
      end
    end
    
    
  end
end
