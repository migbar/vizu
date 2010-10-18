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
    @sid = channel.subscribe { |m| send_data "#{process m}\n" }
  end
  
  def process(msg)
    msg.upcase
  end

  def unbind
    channel.unsubscribe @sid
  end
  
  def self.host
    '0.0.0.0'
  end
end