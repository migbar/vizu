class Accessibility < Broadcaster

  def self.port
    1250
  end
  
  def channel
    Channels::Accessibility
  end

end