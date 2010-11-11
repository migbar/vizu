class Filter
  attr_reader :predicates, :match_method
  
  def initialize(opts={})
    options = {
      :definition_type => "any",
      :predicates      => []
    }.merge(opts)

    @match_method = options[:definition_type].downcase.to_sym
    @predicates = options[:predicates].collect do |hash|
      Predicate.new hash.symbolize_keys
    end
    
  end
  
  def matches?(line)             
    puts "111"
    return false if predicates.empty? 
    puts "222"
    result = self.send(match_method, line)
    puts "333"
    puts "matching #{match_method}, with #{line.inspect} - result is #{result}"
    result
  end
  
  private
    def any(line)
      puts "in any with line #{line.inspect}"
      !!predicates.detect { |pred| pred.matches? line }
    end
  
    def all(line)                            
      
        puts "in all with line #{line.inspect}"
      predicates.each { |pred| return false unless pred.matches? line }
      true
    end
end