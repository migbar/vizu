require 'spec_helper'

describe Vizu do
  
  before(:each) do
    EM.stub(:run)
  end
  
  it "starts the LogReceiver" do
    LogReceiver.should_receive(:start)
    puts "HEREEEEEEEEEEEEEEEEEEEEEEEEEE"
    Vizu.start
  end
end