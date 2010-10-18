class Transaction < Broadcaster
  def self.port
    1270
  end
  
  def channel
    Channels::Transaction
  end
  
end