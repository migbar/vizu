class Predicate
  attr_reader :entity, :operand, :value
  
  def initialize(options)
    @entity = options[:entity]
    @operand = options[:operand].to_sym
    @value = options[:value]
  end
  
  def matches?(line)
    self.send(operand, value, line)
  end

  private
    def equals(value, line)    
      target(line).to_s.downcase == value.to_s.downcase
    end
   
    def does_not_equal(value, line)
      !equals(value, line)
    end
  
    def greater_than(value, line)
      target(line).to_i > value.to_i
    end
  
    def less_than(value, line)
      target(line).to_i < value.to_i
    end
  
    def like(value, line)
      target(line).downcase =~ Regexp.new(value.downcase)
    end
  
    def target(line)    
      line[self.entity.to_sym]
    end
  
end