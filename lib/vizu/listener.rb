# Listener class will connect to NetStar servers and 

class Listener 
  NETSTAR_SERVERS ={
    :mbhorspwas1 => [9085, 9095, 9075, 9065], 
    :mbhorspwas2 => [9085, 9095, 9075, 9065], 
    :mbhorspwas3 => [9085, 9095, 9075, 9065], 
    :mbhorspwas4 => [9085, 9095, 9075, 9065], 
    :mbhorspcma6 => [9085], 
    :mbhorspcma7 => [9085],
    :mbusahosp11 => [7015, 9015],
    :mbusahosp12 => [7015, 9015],
    :mbusahosw11 => [7015, 9015],
    :mbusahosw12 => [7015, 9015]
  }

  NETSTAR_SERVERS.each_key do |server|
    NETSTAR_SERVERS[server].each do |port|
      puts "connecting to server: #{server.to_s}, and port: #{port}"
      # EM.connect(server, port) do |conn|
      #   conn.extend EM::P::LineText2
      #   def conn.receive_line(line)
      #     process(line)
      #   end
      # end
    end
  end

  def process(line)
    channel(line) << Processor.digest(line)
  end
  
  # This part of the example is more fake, but imagine sleep was in fact a 
  # long running calculation to achieve the value.
  def self.start_all
    200.times do
      EM.defer lambda { v = sleep(rand * 2); Channels::Accessibility << ["A", Time.now, v]}
      EM.defer lambda { v = sleep(rand * 2); Channels::Portal        << ["P", Time.now, v] }
      EM.defer lambda { v = sleep(rand * 2); Channels::Transaction   << ["T", Time.now, v] }
    end
  end
  
end




