# The Broadcaster simply subscribes client connections to the channel on connect,
# and unsubscribes them on disconnect.

class Broadcaster < EM::Connection
  @broadcasters = []
  
  def self.inherited(child)
    @broadcasters << child
  end

  def self.start_all
    @broadcasters.each do |b|
       EM.start_server(host, b.port, b)
    end
  end
  
  def post_init
    #find out something about the incoming client, subscribe him to the channel he wants
    @sid = channel.subscribe { |line| send_data "#{process line}\n" }
  end
  
  def process(line)
    GourceProcessor.process(line)
    # msg.upcase
  end

  def unbind
    channel.unsubscribe @sid
  end
  
  def self.host
    '0.0.0.0'
  end
end