require 'spec_helper'

describe Filter do

  describe "#matches" do
    before(:each) do
      @line = { :server => "server1", :duration => 345, :rpc => "N788XIO", :application => "sales" }
    end
    
    describe "no predicates" do
      it "never matches" do
        Filter.new.matches?(@line).should be_false      
      end
    end
    
    describe "one predicate" do
      it "matches if type is 'any' and the only predicate matches" do
        predicates = [ { :entity => "server", :operand => "equals", :value => "server1" } ]
        any_filter = Filter.new :definition_type => "any", :predicates => predicates
        any_filter.matches?(@line).should be_true
      end
      
      it "doesnt match if type is 'any' and the only predicate does not match" do
        predicates = [ { :entity => "server", :operand => "equals", :value => "serverFOOBAR" } ]
        any_filter = Filter.new :definition_type => "any", :predicates => predicates
        any_filter.matches?(@line).should be_false
      end
      
      it "matches if type is 'all' and the only predicate matches" do
        predicates = [ { :entity => "server", :operand => "equals", :value => "server1" } ]
        all_filter = Filter.new :definition_type => "all", :predicates => predicates
        all_filter.matches?(@line).should be_true
      end
      
      it "doesnt match if type is 'all' and the only predicate does not match" do
        predicates = [ { :entity => "server", :operand => "equals", :value => "server1FOOBAR" } ]
        all_filter = Filter.new :definition_type => "all", :predicates => predicates
        all_filter.matches?(@line).should be_false
      end
    end
    
    describe "mulitple predicates" do
      
      it "matches if type is 'any' and at least one predicate matches" do
        predicates = [ {:entity => "server", :operand => "equals", :value => "foobar"},
                        {:entity => "application", :operand => "equals", :value => "sales"}, 
                        {:entity => "duration", :operand => "greater_than", :value => "123"}]
        any_filter = Filter.new :definition_type => "any", :predicates => predicates
        any_filter.matches?(@line).should be_true
      end

      it "does not match if type is 'any' and no predicates match" do
        predicates = [ {:entity => "server", :operand => "equals", :value => "foobar"},
                        {:entity => "application", :operand => "equals", :value => "xyz"}, 
                        {:entity => "duration", :operand => "greater_than", :value => "666"}]
        any_filter = Filter.new :definition_type => "any", :predicates => predicates
        any_filter.matches?(@line).should be_false
      end
      
      it "matches if type is 'all' and all predicates match" do
        predicates = [ {:entity => "server", :operand => "equals", :value => "server1"},
                        {:entity => "application", :operand => "equals", :value => "sales"}, 
                        {:entity => "duration", :operand => "greater_than", :value => "0"}]
        all_filter = Filter.new :definition_type => "all", :predicates => predicates
        all_filter.matches?(@line).should be_true
      end
      
      it "does not match if type is 'all' and not all predicates match" do
        predicates = [ {:entity => "server", :operand => "equals", :value => "server1"},
                        {:entity => "application", :operand => "equals", :value => "salesXYZ"}, 
                        {:entity => "duration", :operand => "greater_than", :value => "0"}]
        all_filter = Filter.new :definition_type => "all", :predicates => predicates
        all_filter.matches?(@line).should be_false
      end
  
    end
  end

end
