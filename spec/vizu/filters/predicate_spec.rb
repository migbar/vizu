require 'spec_helper'

describe Predicate do
  describe "#initialize" do
    it "sets the state from the options" do
      p = Predicate.new({:entity => "server", :operand => "equals", :value => "foobar"})
      p.entity.should == "server"
      p.operand.should == :equals
      p.value.should == "foobar"
    end
  end

  describe "#matches?" do
    before(:each) do
      @line = {:server => "server1", :duration => 345, :rpc => "N788XIO", :application => "sales"}
    end
    
    it "matches correctly using equals" do
      p = Predicate.new({:entity => "server", :operand => "equals", :value => "server1"})
      p.matches?(@line).should be_true
      
      p = Predicate.new({:entity => "server", :operand => "equals", :value => "serv"})
      p.matches?(@line).should be_false      
      
      p = Predicate.new({:entity => "server", :operand => "equals", :value => "foobar"})
      p.matches?(@line).should be_false
    end
    
    it "matches correctly using does_not_equal" do
      p = Predicate.new({:entity => "server", :operand => "does_not_equal", :value => "server1"})
      p.matches?(@line).should be_false
      
      p = Predicate.new({:entity => "server", :operand => "does_not_equal", :value => "foobar"})
      p.matches?(@line).should be_true
      
      p = Predicate.new({:entity => "server", :operand => "does_not_equal", :value => "serv"})
      p.matches?(@line).should be_true
    end
    
    it "matches correctly using greater than" do
      p = Predicate.new({:entity => "duration", :operand => "greater_than", :value => "100"})
      p.matches?(@line).should be_true
      
      p = Predicate.new({:entity => "duration", :operand => "greater_than", :value => "99999"})
      p.matches?(@line).should be_false      
    end
    
    it "matches correctly using less than" do
      p = Predicate.new({:entity => "duration", :operand => "less_than", :value => "100"})
      p.matches?(@line).should be_false
      
      p = Predicate.new({:entity => "duration", :operand => "less_than", :value => "99999"})
      p.matches?(@line).should be_true      
    end
    
    it "matches correctly using like" do
      p = Predicate.new({ :entity => "server", :operand => "like", :value => "Serv" })
      p.matches?(@line).should be_true
    end
    
  end
end
