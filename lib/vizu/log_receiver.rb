class LogReceiver < EM::Connection
  include EM::P::LineText2
  
  def self.start
     EM.start_server(host, port, self)
     puts "STARTED THE SERVER on #{port}"
  end
  
  def post_init
    puts "GOT THE CONNECTION ON #{LogReceiver.port}"
  end
  
  def receive_line(line)
    # EM.defer lambda { broadcast line }
    broadcast line
  end
  
  def broadcast(line)
    # v = sleep(rand * 12) #simulate an expensive process function ...
    get_channel(line).push process(line) #channel is determined by the line content
  end
  
  def process(line)      
    # puts "processing ... #{line}"
    line[3..line.length-1]
  end
  
  def get_channel(line)
    # rpc = line.split("\t").to_a[7].strip.split(" ")[1] 
    Channels::Accessibility  
  end
  
  def unbind
    puts "LOST CONNECTION TO THE NETSTAR SERVER"
    # channel.unsubscribe @sid
  end
  
  def self.host
    '0.0.0.0'
  end
  
  def self.port
    8887
  end
end