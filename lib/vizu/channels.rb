module Channels
  # Create channels to push data to
  Accessibility = EM::Channel.new
  Portal        = EM::Channel.new
  Transaction   = EM::Channel.new
end