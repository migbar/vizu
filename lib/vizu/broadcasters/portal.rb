class Portal < Broadcaster
  def self.port
    1260
  end
  
  def channel
    Channels::Portal
  end
  
end