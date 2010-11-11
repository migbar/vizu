class Filter
  attr_reader :predicates, :match_method
  
  def initialize(opts={})
    options = {
      :definition_type => "any",
      :predicates      => []
    }.merge(opts)

    @match_method = options[:definition_type].downcase.to_sym
    @predicates = options[:predicates].collect { |hash| Predicate.new hash.symbolize_keys }
  end
  
  def matches?(line)             
    return false if predicates.empty? 
    self.send(match_method, line)
  end
  
  private
    def any(line)
      !!predicates.detect { |pred| pred.matches? line }
    end
  
    def all(line)                            
      predicates.each { |pred| return false unless pred.matches? line }
      true
    end
end