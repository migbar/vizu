require 'spec_helper'

describe Vizu do
  
  before(:each) do
    # EM.stub(:run)
  end
  
  it "starts the LogReceiver" do
    # LogReceiver.should_receive(:start)
    EM.should_receive(:run).and_yield
    Vizu.should_receive(:run)
    Vizu.start
  end
end

