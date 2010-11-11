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
      r = target(line).to_s.downcase == value.to_s.downcase
      puts "matches #{target(line).to_s.downcase} to #{value.to_s.downcase} .. result is #{r}"
      
      r
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
      puts "line is #{line.inspect } and  the entity to sym is #{self.entity.to_sym}"
      line[self.entity.to_sym]
    end
  
end