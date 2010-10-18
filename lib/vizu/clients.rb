class Clients
  PORTS = [1250, 1260, 1270]
  
  def self.come_in
    # Two client connections for each port, that just print what they receive.
    PORTS.each do |port|
      2.times do
        puts "client connection looking for accessibility"
        EM.connect('0.0.0.0', port) do |c|
          c.extend EM::P::LineText2
          def c.receive_line(line)
            puts "Subscriber: #{signature} got #{line}"
          end
          # EM.add_timer(2) { c.close_connection }
        end
      end
    end
  end
  
end
